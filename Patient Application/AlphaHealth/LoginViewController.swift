//
//  LoginViewController.swift
//  AlphaHealth
//
//  Created by Saransh Mittal on 10/03/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet var backgroundGradient: UIView!
    
    func setBackgroundGradientColor(){
        func setGradientBackground() {
            let colorTop =  UIColor(red: 255.0/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0).cgColor
            let colorBottom = UIColor(red: 224/255.0, green: 239/255.0, blue: 255/255.0, alpha: 1.0).cgColor
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [ 0.0, 1.0]
            gradientLayer.frame = self.view.bounds
            self.view.layer.insertSublayer(gradientLayer, at: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundGradient.dropShadow()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: -2, height: 2)
        layer.shadowRadius = 1
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
