//
//  DiseaseTableViewController.swift
//  AlphaHealthDoctor
//
//  Created by Saransh Mittal on 12/03/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class DiseaseTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return diseases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = diseases[indexPath.row][1]
        return cell
    }
    
    @IBAction func sendTransaction(_ sender: Any) {
        submitDiagnose()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndex = indexPath.row
    }
    
    var selectedIndex = 0
    
    func submitDiagnose() {
        let locValue: CLLocationCoordinate2D = (locationManager.location?.coordinate)!
        var latitude = String(locValue.latitude)
        var longitude = String(locValue.longitude)
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let url = "http://epionecare.herokuapp.com/addTest"
        var code = "GEkKQDKFf5qzi7WwY2VzwBd3VyLhCu1aSaWjSAU7dCpo"
        var privateKey = "7jWaeDMRTdTx6YZkpiRHEBhgoHWURrAAn31n5cuepVRL"
        let x = ["pubKey":code,
                 "priKey":privateKey,
                 "latitude":String(latitude)!,
                 "longitude":String(longitude)!,
                 "diseaseName":String(diseases[selectedIndex][1])!,
                 "diseaseID":String(diseases[selectedIndex][0])!
        ]
        print(x)
        Alamofire.request(url, method: .post, parameters: x).responseJSON{response in
                print(response.result.value)
                if response.result.isSuccess{
                    self.navigationController?.popViewController(animated: true)
                } else {
                    let alert = UIAlertController(title: "Failure", message: "Data not saved", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
