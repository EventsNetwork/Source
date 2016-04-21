//
//  ProvinceCell.swift
//  LetsTravel
//
//  Created by TriNgo on 4/21/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

class ProvinceCell: UITableViewCell {

    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var provinceName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
