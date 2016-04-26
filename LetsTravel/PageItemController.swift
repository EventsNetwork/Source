//
//  PageItemController.swift
//  LetsTravel
//
//  Created by TriNgo on 4/17/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

@objc protocol PageItemControllerDelegate {
    func pageItemClick(tour: Tour)
}

class PageItemController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var totalDayLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    weak var delegate: PageItemControllerDelegate?
    
    // MARK: - Variables
    var itemIndex: Int = 0
    var imageName: String = "" {
        didSet {
            if let imageView = imageView {
                imageView.image = UIImage(named: imageName)
            }
        }
    }
    var tour: Tour!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView!.image = UIImage(named: imageName)
        
        descriptionLabel.text = tour.desc
        totalDayLabel.text = String(tour.totalDay! as Int)
        costLabel.text = String(tour.maxCost! as Double)
        
        let gestureReg = UITapGestureRecognizer()
        gestureReg.addTarget(self, action: "onViewClick:")
        view.addGestureRecognizer(gestureReg)
    }
    
    func onViewClick(sender: UIPanGestureRecognizer) {
        delegate?.pageItemClick(tour)
    }
}
