//
//  HistoryViewController.swift
//  AlphaHealth
//
//  Created by Saransh Mittal on 11/03/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    "doctorAskedForReports",
    
    var y = [NSDictionary]()
    
    let x = ["patientRegularCheckup", "diagnosedDisease", "patientRegularCheckupReport"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return y.count+3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = medicalHistoryTable.dequeueReusableCell(withIdentifier: x[2], for: indexPath)
            return cell
        }
        if indexPath.row == 1{
            let cell = medicalHistoryTable.dequeueReusableCell(withIdentifier: x[1], for: indexPath)
            return cell
        }
        if indexPath.row == 2{
            let cell = medicalHistoryTable.dequeueReusableCell(withIdentifier: x[0], for: indexPath)
            return cell
        }
        let cell = medicalHistoryTable.dequeueReusableCell(withIdentifier: "doctorDiagnosedDisease", for: indexPath) as! testTableViewCell
        cell.dueDate.text = "Due: " + (y[indexPath.row-3]["dueDate"] as! String)
        cell.review.text = y[indexPath.row-3]["note"] as! String
        cell.testName.text = y[indexPath.row-3]["testName"] as! String
        return cell
    }

    @IBOutlet weak var medicalHistoryTable: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        Database.database().reference().child("tests").observe(.value, with: {snapchat in
            if let value = snapchat.value as? NSDictionary{
                self.y.removeAll()
                for (key, val) in value{
                    var x = val as! NSDictionary
                    self.y.append(x as! NSDictionary)
                }
            }
            print(self.y)
            self.medicalHistoryTable.reloadData()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        Database.database().reference().child("tests").observe(.value, with: {snapchat in
//            print(snapchat.value)
//            self.y = [snapchat.value as! NSDictionary]
//            print(self.y)
//            self.medicalHistoryTable.reloadData()
//        })
//        Database.database().reference().child("tests").observe(.childAdded, with: {snapchat in
//            Database.database().reference().child("tests").observe(.value, with: {snapchat in
//                print(snapchat.value)
//                self.y = [snapchat.value as! NSDictionary]
//                print(self.y)
//                self.medicalHistoryTable.reloadData()
//            })
//        })
//        dueDate = "";
//        note = "";
//        testName = "";
        medicalHistoryTable.delegate = self
        medicalHistoryTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
