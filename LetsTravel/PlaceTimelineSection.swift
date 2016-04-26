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

class PlaceTimelineSection: UIView {
    
    var section: Int!
    
    weak var delegate: PlaceTimelineSectionDelegate?
    
    var closeButton: UIButton!
    var hideCloseButton: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       // initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    convenience init(section: Int, frame: CGRect, hideCloseButton: Bool) {
        self.init(frame: frame)
        self.section = section
        self.hideCloseButton = hideCloseButton
        initView()
    }
    
    func initView() {
        let text = "Day \(section + 1)"
        let label = UILabel(frame: CGRectMake(11, 2, frame.size.width/2 - 50, 25))
        let closeButton = UIButton(frame: CGRectMake(frame.size.width - 100, 5, 15, 15))
        
        label.text = text
        label.font.fontWithSize(12)
        label.textColor = UIColor.whiteColor()
    
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.setImage(UIImage(named: "cross"), forState: .Normal)
        closeButton.addTarget(self, action:"buttonHeaderClick:", forControlEvents: UIControlEvents.TouchUpInside)
        closeButton.tintColor = UIColor.whiteColor()
        
        insertSubview(label, atIndex: 0)
        addSubview(closeButton)
        
        closeButton.rightAnchor.constraintEqualToAnchor(self.rightAnchor, constant: -8).active = true
        closeButton.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor).active = true
        closeButton.heightAnchor.constraintEqualToConstant(20).active = true
        closeButton.widthAnchor.constraintEqualToConstant(20).active = true
        
        backgroundColor = UIColor(red: 82.0/255.0, green: 191.0/255.0, blue: 144.0/255.0, alpha: 0.8)
        
        print(hideCloseButton)
        
        if hideCloseButton == true {
            closeButton.hidden = true
        }
    }
    
    func buttonHeaderClick(sender: UIButton) {
        delegate?.removeClicK(section)
    }
}
