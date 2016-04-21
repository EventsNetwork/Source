//
//  CreatePlaceCell.swift
//  LetsTravel
//
//  Created by HoangNguyen on 4/18/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

enum PlaceOption: Int {
    case Play
    case Eat
    case Go
    case Rest
    
    static let allValues = [Play, Eat, Go, Rest]
}

@objc protocol CreatePlaceCellDelegate {
    func choosePlaceOption(cell: UITableViewCell)
}

class CreatePlaceCell: UITableViewCell {

    @IBOutlet weak var placeOptionsParentView: UIView!
    @IBOutlet weak var newPlaceButton: UIButton!
    @IBOutlet weak var placeOptionsView: UIStackView!
   
    weak var delegate: CreatePlaceCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func newPlaceClick(sender: UIButton) {
        let subviews = placeOptionsView.subviews
        for view in subviews {
            view.hidden = true
        }
        self.placeOptionsParentView.hidden = true
        self.placeOptionsParentView.alpha = 0.5
        UIView.animateWithDuration(1, animations: {
            self.placeOptionsParentView.hidden = false
            self.placeOptionsParentView.alpha = 1
        }) { (done: Bool) in
            self.animateSubViews(0)
        }
    }
    
    @IBAction func choosePlaceOption(sender: AnyObject) {
        delegate?.choosePlaceOption(self)
    }
    
    func animateSubViews(index: Int) {
        let subviews = placeOptionsView.subviews
        
        guard index < subviews.count else {
            return
        }
        
        UIView.animateWithDuration(0.1, animations: {
            subviews[index].hidden = false
        }) { (done: Bool) in
            self.animateSubViews(index + 1)
        }
    }
    
}
