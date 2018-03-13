//
//  PatientHistoryTableViewCell.swift
//  AlphaHealthDoctor
//
//  Created by Saransh Mittal on 12/03/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit

class PatientHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var imageThree: UIImageView!
    @IBOutlet weak var imageTwo: UIImageView!
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var appointmentDate: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
