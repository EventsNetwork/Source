//
//  PlaceSection.swift
//  LetsTravel
//
//  Created by HoangNguyen on 4/19/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

@objc protocol PlaceSectionDelegate {
    func removeClicK(section: Int)
}

class PlaceSection: UIView {
    
    var section: Int!
    
    weak var delegate: PlaceSectionDelegate?
    
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
        let label = UILabel(frame: CGRectMake(8, 5, frame.size.width/2 - 50, 30))
        let button = UIButton(frame: CGRectMake(frame.size.width - 100, 5, 100, 30))
        label.text = text
        button.titleLabel?.font.fontWithSize(14)
        button.titleLabel?.textColor = UIColor.blackColor()
        button.setTitle("Remove", forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(self.buttonHeaderClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        insertSubview(label, atIndex: 0)
        addSubview(button)
        
        backgroundColor = UIColor.lightGrayColor()
    }
    
    func buttonHeaderClick(sender: UIButton) {
        delegate?.removeClicK(section)
    }
}
