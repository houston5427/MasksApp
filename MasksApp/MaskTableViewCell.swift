//
//  MaskTableViewCell.swift
//  MasksApp
//
//  Created by Glen Lin on 2020/2/15.
//  Copyright © 2020 Glen Lin. All rights reserved.
//

import UIKit

class MaskTableViewCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var adultLabel: UILabel!
    @IBOutlet weak var childLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
