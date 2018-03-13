//
//  requestMedicalReportViewController.swift
//  AlphaHealthDoctor
//
//  Created by Saransh Mittal on 12/03/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit
import FirebaseDatabase

class requestMedicalReportViewController: UIViewController, UITextFieldDelegate {

    @IBAction func submit(_ sender: Any) {
        let x = [
            "note":reviewerNote.text,
            "dueDate":dueDate.text,
            "testName":testName.text
        ]
        Database.database().reference().child("tests").childByAutoId().setValue(x) {
            (error, response) in
            if error == nil{
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                let alert = UIAlertController(title: "Oops!", message: "Test not created!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var reviewerNote: UITextField!
    @IBOutlet weak var dueDate: UITextField!
    @IBOutlet weak var testName: UITextField!
    
    var constant:CGFloat = 180.0
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.27) {
            self.topConstraint.constant -= self.constant
            self.bottomConstraint.constant += self.constant
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !(self.reviewerNote.isEditing || self.dueDate.isEditing || self.testName.isEditing) {
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.27, animations: {
                self.topConstraint.constant += self.constant
                self.bottomConstraint.constant -= self.constant
                self.view.layoutIfNeeded()
            })
        }
    }
    @objc func dismissKeyboard() {
        reviewerNote.resignFirstResponder()
        dueDate.resignFirstResponder()
        testName.resignFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewerNote.delegate = self
        dueDate.delegate = self
        testName.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(requestMedicalReportViewController.dismissKeyboard)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
