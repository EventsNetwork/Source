//
//  PlaceTimelineCell.swift
//  LetsTravel
//
//  Created by HoangNguyen on 4/20/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

@objc protocol PlaceTimelineCellDelegate {
    func placeRemove(cell: UITableViewCell)
}

class PlaceTimelineCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var placeImageView: UIImageView!
    
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var descLabel: UILabel!
    
    var place: Place! {
        didSet {
            nameLabel.text = place.name
            descLabel.text = place.desc
            if let imgUrls = place.imageUrls where imgUrls.count > 0 {
                placeImageView.setImageWithURL(NSURL(string: imgUrls[0])!, placeholderImage: UIImage(named: "placeholder"))
            } else {
                placeImageView.image = UIImage(named: "placeholder")
            }
        }
    }
    
    weak var delegate: PlaceTimelineCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        placeImageView.layer.cornerRadius = 10

    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func removeClick(sender: UIButton) {
        delegate?.placeRemove(self)
    }
}
