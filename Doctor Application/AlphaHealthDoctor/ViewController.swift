//
//  ViewController.swift
//  AlphaHealthDoctor
//
//  Created by Saransh Mittal on 11/03/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftWebSocket

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    struct healthCode {
        var count = 0
        var name = ""
        var code = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        connect()
    }
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var transactionTable: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "disease", for: indexPath) as! DashboardTableViewCell
        cell.diseaseName.text = diseaseTableData[indexPath.row].name
        cell.diseaseCode.text = "ICB CODE " + diseaseTableData[indexPath.row].code
        cell.numberOFCases.text = String(diseaseTableData[indexPath.row].count) + " Cases this month"
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diseaseTableData.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        diseaseCode = diseaseTableData[indexPath.row].code
        diseaseName = diseaseTableData[indexPath.row].name
        diseaseCases = String(diseaseTableData[indexPath.row].count)
    }

    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    var transactionInformation = [NSDictionary]()
    var transactions = [NSDictionary]()
    var diseaseTableData = [healthCode]()
    var temp = healthCode()
    
//    override func viewDidDisappear(_ animated: Bool) {
//        socket.close()
//    }
    
    let socket = WebSocket("ws://139.59.12.96:59985/api/v1/streams/valid_transactions")
    
    func connect(){
        socket.event.open = {
            print("opened")
        }
        socket.event.close = { code, reason, clean in
            print("closed")
        }
        socket.event.error = { error in
            print("error \(error)")
        }
        socket.event.message = { message in
            let x = self.convertToDictionary(text: String(describing: message))
            self.transactions = [x as! NSDictionary] + self.transactions
            Alamofire.request("http://139.59.12.96:59984/api/v1/transactions/" + String(describing: x!["asset_id"]!)).responseJSON{
                response in
                let x:NSDictionary = response.result.value! as! NSDictionary
                let y:NSDictionary = x["metadata"] as! NSDictionary
                do{
                    print(y)
                    if (y["diseaseID"] != nil) {
                        print("echo")
                        let latitude:CLLocationDegrees = Double(y["latitude"] as! String)!
                        let longitude:CLLocationDegrees = Double(y["longitude"] as! String)!
                        let code = y["diseaseID"] as! String
                        let name = y["diseaseName"] as! String
                        let d = y["datetime"] as! String
                        let y = [
                            "latitude":latitude,
                            "longitude":longitude,
                            "date":d,
                            "code": code,
                            "name": name,
                            "count":1
                            ] as [String : Any]
                        self.transactionInformation = [y as NSDictionary] + self.transactionInformation
                        self.setMap(latitude: latitude, longitude: longitude, date: d, disease: name)
                        let h = [
                            "count":1,
                            "code":code,
                            "name":name
                            ] as [String : Any]
                        
                        self.temp.code = code
                        self.temp.name = name
                        self.temp.count = 1
                        self.diseaseTableData.append(self.temp)
                        
                        var p = 0
                        for i in 0...self.diseaseTableData.count{
                            p = i+1
                            while(p<self.diseaseTableData.count){
                                if self.diseaseTableData[i].code == self.diseaseTableData[p].code{
                                    self.diseaseTableData[i].count = self.diseaseTableData[i].count + 1
                                    self.diseaseTableData.remove(at: p)
                                } else {
                                    p = p+1
                                }
                            }
                        }
                        
                        print(self.diseaseTableData)
                        self.transactionTable.reloadData()
                    }
                } catch {
                    // do nothing
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        transactionTable.delegate = self
        transactionTable.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        map.mapType = MKMapType.standard
        connect()
    }
    
    func setMap(latitude:CLLocationDegrees, longitude:CLLocationDegrees, date:String, disease:String){
        let location = CLLocationCoordinate2D(latitude: latitude,longitude: longitude)
        let span = MKCoordinateSpanMake(5.55, 5)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = disease
        annotation.subtitle = date
        map.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

