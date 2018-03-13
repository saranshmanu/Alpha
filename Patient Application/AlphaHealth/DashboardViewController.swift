//
//  DashboardViewController.swift
//  AlphaHealth
//
//  Created by Saransh Mittal on 11/03/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit
import HealthKit
import Alamofire
import CoreLocation

var latitude = ""
var longitude = ""

class DashboardViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var qrCode: UIImageView!
    var qrcodeImage: CIImage!
    var code = "GEkKQDKFf5qzi7WwY2VzwBd3VyLhCu1aSaWjSAU7dCpo"
    var privateKey = "7jWaeDMRTdTx6YZkpiRHEBhgoHWURrAAn31n5cuepVRL"
    let locationManager = CLLocationManager()

    @IBAction func ShareAction(_ sender: Any) {
        let locValue: CLLocationCoordinate2D = (locationManager.location?.coordinate)!
        latitude = String(locValue.latitude)
        longitude = String(locValue.longitude)
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let url = "ws://epionecare.herokuapp.com/push2chain"
        let x = ["pubKey":code,
                 "priKey":privateKey,
                 "latitude":latitude,
                 "longitude":longitude,
                 "heightTag":heightTag,
                 "bodyMassTag":bodyMassTag,
                 "bodyMassIndexTag":bodyMassIndexTag,
                 "stepCountTag":stepCountTag,
                 "distanceWalkingRunningTag":distanceWalkingRunningTag,
                 "activeEnergyBurnedTag":activeEnergyBurnedTag,
                 "flightClimbedTag":flightClimbedTag
        ]
        print(x)
        Alamofire.request(url, method: .post, parameters: ["pubKey":code,
                                                           "priKey":privateKey,
                                                           "latitude":String(latitude),
                                                           "longitude":String(longitude),
                                                           "heightTag":heightTag,
                                                           "bodyMassTag":bodyMassTag,
                                                           "bodyMassIndexTag":bodyMassIndexTag,
                                                           "stepCountTag":stepCountTag,
                                                           "distanceWalkingRunningTag":distanceWalkingRunningTag,
                                                           "activeEnergyBurnedTag":activeEnergyBurnedTag,
                                                           "flightClimbedTag":flightClimbedTag
            ]).responseJSON{response in
                print(response.result.value)
                if response.result.isSuccess{
                    let alert = UIAlertController(title: "Success", message: "Data successfully saved in blockchain network", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Failure", message: "Data not saved", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
        }
    }
    @IBOutlet weak var publicKeyLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var BMILabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("hey location is being updated")
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        latitude = String(locValue.latitude)
        longitude = String(locValue.longitude)
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // For generating qr code
        if self.qrcodeImage == nil {
            if code == "" {
                print("no qr code available")
                return
            }
            let data = code.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
            let filter = CIFilter(name: "CIQRCodeGenerator")
            let colorFilter = CIFilter(name: "CIFalseColor")
            filter?.setValue(data, forKey: "inputMessage")
            filter?.setValue("Q", forKey: "inputCorrectionLevel")
            colorFilter?.setValue(filter?.outputImage, forKey: "inputImage")
            colorFilter?.setValue(CIColor.init(red: 1, green: 1, blue: 1, alpha: 0), forKey: "inputColor1")
            colorFilter?.setValue(CIColor(red: 1, green: 1, blue: 1, alpha: 1), forKey: "inputColor0")
            self.qrcodeImage = colorFilter?.outputImage
            self.displayQRCodeImage()
        }
        self.qrCode.alpha = 1.0
        getHealthKitPermission()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            // your code here
            self.heightLabel.text = self.heightTag
            self.calorieLabel.text = self.activeEnergyBurnedTag
            self.distanceLabel.text = self.distanceWalkingRunningTag
            self.BMILabel.text = self.bodyMassIndexTag
            self.weightLabel.text = self.bodyMassTag
            self.stepsLabel.text = self.stepCountTag
        }
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    func displayQRCodeImage() {
        let scaleX = qrCode.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = qrCode.frame.size.height / qrcodeImage.extent.size.height
        let transformedImage = qrcodeImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        qrCode.image = UIImage(ciImage: transformedImage)
        qrCode.contentMode = .scaleAspectFit
    }
    
    let healthkitStore = HKHealthStore()
    let height = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)
    let bodyMass = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)
    let bodyMassIndex = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMassIndex)
    let stepCount = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
    let distanceWalkingRunning = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)
    let activeEnergyBurned = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)
    let flightClimbed = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.flightsClimbed)
    
    var heightTag = ""
    var bodyMassTag = ""
    var bodyMassIndexTag = ""
    var stepCountTag = ""
    var distanceWalkingRunningTag = ""
    var activeEnergyBurnedTag = ""
    var flightClimbedTag = ""
    
    func getHealthKitPermission() {
        let healthkitTypesToRead = NSSet(array: [
            height,
            bodyMass,
            bodyMassIndex,
            stepCount,
            distanceWalkingRunning,
            activeEnergyBurned,
            flightClimbed
            ])
        
        let healthkitTypesToWrite = NSSet(array: [
            // Here we are only requesting access to write for the amount of Energy Burned.
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned) ?? "",
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height) ?? "",
            ])
        
        healthkitStore.requestAuthorization(toShare: healthkitTypesToWrite as? Set, read: healthkitTypesToRead as? Set) { (success, error) in
            if success {
                print("Permission accept.")
                self.readData()
            } else {
                if error != nil {
                    print(error ?? "")
                }
                print("Permission denied.")
            }
        }
    }
    
    func readData(){
        queryData(sampleType: height!)
        queryData(sampleType: bodyMass!)
        queryData(sampleType: bodyMassIndex!)
        queryHealth(indentifier: .stepCount)
        queryHealth(indentifier: .distanceWalkingRunning)
        queryData(sampleType: activeEnergyBurned!)
        queryHealth(indentifier: .flightsClimbed)
    }
    
    func queryData(sampleType:HKSampleType) {
        let query = HKSampleQuery(sampleType: sampleType, predicate: nil, limit: 1, sortDescriptors: nil) { (query, results, error) in
            if let result = results?.first as? HKQuantitySample{
                print("Result => \(result.quantity)")
                if sampleType == self.height {
                    self.heightTag = String(describing: result.quantity)
                }
                if sampleType == self.bodyMass {
                    self.bodyMassTag = String(describing: result.quantity)
                }
                if sampleType == self.bodyMassIndex {
                    self.bodyMassIndexTag = String(describing: result.quantity)
                }
                if sampleType == self.activeEnergyBurned {
                    self.activeEnergyBurnedTag = String(describing: result.quantity)
                }
            }else{
                print("OOPS didnt get height \nResults => \(results), error => \(error)")
            }
        }
        self.healthkitStore.execute(query)
    }
    
    func queryHealth(indentifier: HKQuantityTypeIdentifier) {
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        let quantityType = HKQuantityType.quantityType(forIdentifier: indentifier)!
        let query = HKStatisticsQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            guard let result = result, let sum = result.sumQuantity() else {
                return
            }
            if indentifier == .stepCount {
                self.stepCountTag = String(describing: sum)
            }
            if indentifier == .distanceWalkingRunning {
                self.distanceWalkingRunningTag = String(describing: sum)
            }
            if indentifier == .flightsClimbed {
                self.flightClimbedTag = String(describing: sum)
            }
            print(sum)
        }
        self.healthkitStore.execute(query)
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
