//
//  charityTableCell.swift
//  Donate
//
//  Created by özgür on 25.12.2015.
//  Copyright © 2015 ozgur. All rights reserved.
//

import UIKit

class CharityListCell: UITableViewCell {

    
    @IBOutlet var charityImage: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var charityDescription: UILabel!

    @IBOutlet var charityUrl: UILabel!
    @IBOutlet var checkMarkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
