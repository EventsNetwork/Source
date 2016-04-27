//
//  CreatePlaceCell.swift
//  LetsTravel
//
//  Created by HoangNguyen on 4/18/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

@objc protocol CreatePlaceCellDelegate {
    func choosePlaceOption(section: Int, sender: UIButton, categoryId:Int)
}

class CreatePlaceCell: UITableViewHeaderFooterView {

    @IBOutlet weak var placeOptionsParentView: UIView!
    @IBOutlet weak var newPlaceButton: UIButton!
    @IBOutlet weak var placeOptionsView: UIStackView!
    
    var section: Int = 0
   
    weak var delegate: CreatePlaceCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        //initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
      //  initView()
    }
    
    func initView() {
        placeOptionsParentView.layer.cornerRadius = 10
        placeOptionsParentView.clipsToBounds = true
        layoutMargins = UIEdgeInsetsZero
    }
    
    func hideOptions() {
        self.placeOptionsParentView.hidden = true
        let subviews = placeOptionsView.subviews
        for view in subviews {
            view.hidden = true
        }
    }

    @IBAction func newPlaceClick(sender: UIButton) {
        let subviews = placeOptionsView.subviews
        for view in subviews {
            view.hidden = true
        }
        self.placeOptionsParentView.hidden = true
        self.placeOptionsParentView.alpha = 0.5
        UIView.animateWithDuration(0.2, animations: {
            self.placeOptionsParentView.hidden = false
            self.placeOptionsParentView.alpha = 1
        }) { (done: Bool) in
            self.animateSubViews(0)
        }
    }
    
    @IBAction func choosePlaceOption(sender: UIButton) {
        delegate?.choosePlaceOption(section, sender: sender, categoryId: 1)
    }
    
    @IBAction func choosePlaceOption2(sender: UIButton) {
        delegate?.choosePlaceOption(section, sender: sender, categoryId: 2)
    }
    
    @IBAction func choosePlaceOption3(sender: UIButton) {
        delegate?.choosePlaceOption(section, sender: sender, categoryId: 3)
    }
    
    func animateSubViews(index: Int) {
        let subviews = placeOptionsView.subviews
        
        guard index < subviews.count else {
            return
        }
        
        UIView.animateWithDuration(0.05, animations: {
            subviews[index].hidden = false
        }) { (done: Bool) in
            self.animateSubViews(index + 1)
        }
    }
    
}
