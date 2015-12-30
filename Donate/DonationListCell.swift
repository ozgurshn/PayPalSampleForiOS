//
//  DonationListCell.swift
//  Donate
//
//  Created by özgür on 28.12.2015.
//  Copyright © 2015 ozgur. All rights reserved.
//

import UIKit

class DonationListCell: UITableViewCell {
 
    @IBOutlet var amount: UITextField!
    @IBOutlet var charityName: UILabel!
    override func awakeFromNib() {
     
       
        super.awakeFromNib()
       
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
