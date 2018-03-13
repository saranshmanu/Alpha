//
//  PatientsHistoryViewController.swift
//  AlphaHealthDoctor
//
//  Created by Saransh Mittal on 12/03/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit

class PatientsHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var historyTableView: UITableView!
    
    var history = [[
            "name":"Saransh Mittal",
            "id":"H859FJ466F5",
            "appointmentDate":"4th March",
            "imageOne":"Green Ticks",
            "imageTwo":"Green Ticks",
            "imageThree":"Clock"
        ],[
            "name":"Ansh Mehra",
            "id":"H859FJ266F5",
            "appointmentDate":"1st March",
            "imageOne":"Green Ticks",
            "imageTwo":"Clock",
            "imageThree":"Clock"
        ],[
            "name":"Harsha Bomanna",
            "id":"J859H3466F5",
            "appointmentDate":"13th Feb",
            "imageOne":"Green Ticks",
            "imageTwo":"Clock",
            "imageThree":"Green Ticks"
        ],[
            "name":"Hemant Kumar",
            "id":"Z859WDZ466F5",
            "appointmentDate":"2nd Feb",
            "imageOne":"Green Ticks",
            "imageTwo":"Green Ticks",
            "imageThree":"Green Ticks"
        ],
    ]
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(withIdentifier: "h", for: indexPath) as! PatientHistoryTableViewCell
        cell.name.text = history[indexPath.row]["name"] as! String
        cell.id.text = history[indexPath.row]["id"] as! String
        cell.appointmentDate.text = "Appointment on " + history[indexPath.row]["appointmentDate"]! as! String
        cell.imageOne.image = UIImage.init(named: history[indexPath.row]["imageOne"] as! String)
        cell.imageTwo.image = UIImage.init(named: history[indexPath.row]["imageTwo"] as! String)
        cell.imageThree.image = UIImage.init(named: history[indexPath.row]["imageThree"] as! String)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.delegate = self
        historyTableView.dataSource = self
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
