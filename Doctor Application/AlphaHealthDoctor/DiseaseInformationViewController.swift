//
//  DiseaseInformationViewController.swift
//  AlphaHealthDoctor
//
//  Created by Saransh Mittal on 11/03/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit

var diseaseName = ""
var diseaseCode = ""
var diseaseCases = ""

class DiseaseInformationViewController: UIViewController {

    @IBOutlet weak var DiseaseCases: UILabel!
    @IBOutlet weak var DiseaseCode: UILabel!
    @IBOutlet weak var DiseaseName: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        DiseaseCases.text = diseaseCases + " Cases this month"
        DiseaseCode.text = "ICB CODE " + diseaseCode
        DiseaseName.text = diseaseName + ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DiseaseCases.text = diseaseCases + " Cases this month"
        DiseaseCode.text = "ICB CODE " + diseaseCode
        DiseaseName.text = diseaseName + ""
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
