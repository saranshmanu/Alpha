//
//  PatientInformationViewController.swift
//  AlphaHealthDoctor
//
//  Created by Saransh Mittal on 11/03/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
import CoreLocation

class PatientInformationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, QRCodeReaderViewControllerDelegate {
    
    @IBOutlet weak var coverView: UIView!
    
    let identify = ["appointmentReport", "bodyStats", "generalStats", "graph", "diagnosedDisease", "doctorAppointment"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = informationTableView.dequeueReusableCell(withIdentifier: identify[indexPath.row], for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func fetchPatientRecord(){
        
    }

    @IBOutlet weak var informationTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        coverView.alpha = 1.0
        coverView.isHidden = false
        informationTableView.delegate = self
        informationTableView.dataSource = self
        scan()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var reader = QRCodeReaderViewController(builder: QRCodeReaderViewControllerBuilder {
        $0.reader = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode])
        $0.showTorchButton = true
    })
    
    // MARK: - QRCodeReader Delegate Methods
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
    }
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        if let cameraName = newCaptureDevice.device.localizedName {
            print("Switching capturing to: \(cameraName)")
        }
    }
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
    }
    
    func scan() {
        do {
            if try QRCodeReader.supportsMetadataObjectTypes() {
                reader.modalPresentationStyle = .pageSheet
                reader.delegate = self
                reader.completionBlock = { (result: QRCodeReaderResult?) in
                    if let result = result {
                        print("Completion with result: \(result.value) of type \(result.metadataType)")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            self.view.layoutIfNeeded()
                            UIView.animate(withDuration: 1, animations: {
                                self.coverView.alpha = 0.0
                                self.view.layoutIfNeeded()
                            }, completion: { com in
                                self.coverView.isHidden = true
                            })
                        }
                        patientPublicKey = result.value
                        self.dismiss(animated: true, completion: {
                            self.fetchPatientRecord()
                        })
                    }
                }
                present(reader, animated: true, completion: nil)
            }
        } catch let error as NSError {
            switch error.code {
            case -11852:
                let alert = UIAlertController(title: "Error", message: "This app is not authorized to use Back Camera.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (_) in
                    DispatchQueue.main.async {
                        if let settingsURL = URL(string: UIApplicationOpenSettingsURLString) {
                            UIApplication.shared.openURL(settingsURL)
                        }
                    }
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
            case -11814:
                let alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
            default:()
            }
        }
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
