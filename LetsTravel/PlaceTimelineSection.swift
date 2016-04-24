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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       // initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    convenience init(section: Int, frame: CGRect) {
        self.init(frame: frame)
        self.section = section
        initView()
    }
    
    func initView() {
        let text = "Day \(section + 1)"
        let label = UILabel(frame: CGRectMake(10, 5, frame.size.width/2 - 50, 30))
        let button = UIButton(frame: CGRectMake(frame.size.width - 100, 5, 40, 40))
        
        label.text = text
        label.font.fontWithSize(13)
        label.textColor = UIColor.whiteColor()
        
        button.titleLabel?.font.fontWithSize(14)
        //button.titleLabel?.textColor = UIColor.blackColor()
        //button.setTitle("Remove", forState: UIControlState.Normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        button.setImage(UIImage(named: "cross"), forState: .Normal)
        button.addTarget(self, action: #selector(self.buttonHeaderClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        button.tintColor = UIColor.whiteColor()
        
        insertSubview(label, atIndex: 0)
        addSubview(button)
        button.rightAnchor.constraintEqualToAnchor(self.rightAnchor, constant: -8).active = true
        button.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor).active = true
        button.heightAnchor.constraintEqualToConstant(30)
        button.widthAnchor.constraintEqualToConstant(30)
        
        backgroundColor = UIColor(red: 82.0/255.0, green: 191.0/255.0, blue: 144.0/255.0, alpha: 0.8)
    }
    
    func buttonHeaderClick(sender: UIButton) {
        delegate?.removeClicK(section)
    }
}
