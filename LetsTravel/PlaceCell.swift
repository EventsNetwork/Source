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
    
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var place: Place! {
        didSet {
            nameLabel.text = place.name
            if let imgUrls = place.imageUrls where imgUrls.count > 0 {
                placeImageView.setImageWithURL(NSURL(string: imgUrls[0])!, placeholderImage: UIImage(named: "placeholder"))
            } else {
                placeImageView.image = UIImage(named: "placeholder")
            }
        }
    }
    
    //weak var delegate: PlaceCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        placeImageView.layer.cornerRadius = 10
        //placeImageView.layer.borderWidth = 1
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
