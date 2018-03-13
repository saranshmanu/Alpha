//
//  testTableViewCell.swift
//  AlphaHealth
//
//  Created by Saransh Mittal on 12/03/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit

class testTableViewCell: UITableViewCell {

    @IBOutlet weak var review: UILabel!
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var testName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
