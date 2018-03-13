//
//  SignupViewController.swift
//  AlphaHealth
//
//  Created by Saransh Mittal on 11/03/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var backgroundGradient: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundGradient.dropShadow()
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
