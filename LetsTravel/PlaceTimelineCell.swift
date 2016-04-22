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
    
    weak var delegate: PlaceTimelineCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
 //       self.backgroundColor = UIColor.lightGrayColor()
        
//        let transparent = UIColor.init(white: 0, alpha: 0).CGColor
//        let opaque = UIColor.init(white: 0, alpha: 1).CGColor
//        
//        let maskLayer = CALayer()
//        maskLayer.frame = self.bounds
//        
//        let gradiantLayer = CAGradientLayer()
//        gradiantLayer.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.size.width, height: self.bounds.size.height)
//        gradiantLayer.colors = [transparent, opaque,
//                                opaque, transparent]
//        
//        gradiantLayer.locations = [0, 0.2, 1 - 0.2, 1]
//        maskLayer.addSublayer(gradiantLayer)
//        
//        self.layer.mask = maskLayer
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func removeClick(sender: UIButton) {
        delegate?.placeRemove(self)
    }
}
