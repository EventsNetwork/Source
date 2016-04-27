//
//  PlaceSection.swift
//  LetsTravel
//
//  Created by HoangNguyen on 4/19/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

@objc protocol PlaceTimelineSectionDelegate {
    func removeClicK(section: Int)
}

class PlaceTimelineSection: UITableViewHeaderFooterView {
    
    var section: Int! {
        didSet {
            if label != nil {
                label.text = "Day \(section + 1)"
            }
        }
    }
    
    weak var delegate: PlaceTimelineSectionDelegate?
    
    var closeButton: UIButton!
    var hideCloseButton: Bool = false
    
    var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       initView()
        
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    func initView() {
        let day = section ?? 0
        let text = "Day \(day + 1)"
        
        label = UILabel(frame: CGRectMake(11, 2, 100, 25))
        let closeButton = UIButton(frame: CGRectMake(frame.size.width - 100, 5, 15, 15))
        
        label.text = text
        label.font.fontWithSize(12)
        label.textColor = UIColor.whiteColor()
    
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.setImage(UIImage(named: "cross"), forState: .Normal)
        closeButton.addTarget(self, action:"buttonHeaderClick:", forControlEvents: UIControlEvents.TouchUpInside)
        closeButton.tintColor = UIColor.whiteColor()
        
        contentView.addSubview(label)
        contentView.addSubview(closeButton)
        
        
        closeButton.rightAnchor.constraintEqualToAnchor(self.rightAnchor, constant: -8).active = true
        closeButton.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor).active = true
        closeButton.heightAnchor.constraintEqualToConstant(20).active = true
        closeButton.widthAnchor.constraintEqualToConstant(20).active = true
        
        contentView.backgroundColor = UIColor(red: 82.0/255.0, green: 191.0/255.0, blue: 144.0/255.0, alpha: 0.8)
        
        if hideCloseButton == true {
            closeButton.hidden = true
        }
    }
    
    func buttonHeaderClick(sender: UIButton) {
        delegate?.removeClicK(section)
    }
}
