//
//  PlaceCell.swift
//  LetsTravel
//
//  Created by HoangNguyen on 4/19/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

//@objc protocol PlaceCellDelegate {
//    func placeRemove(cell: UITableViewCell)
//}

class PlaceCell: UITableViewCell {
    
    var place: Place!
    
    //weak var delegate: PlaceCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
