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
    @IBOutlet var floatRatingView: FloatRatingView!
    
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
//        imageView!.image = UIImage(named: imageName)
        imageView.setImageWithURL(NSURL(string: imageName)!)
        
        
        descriptionLabel.text = tour.desc
        totalDayLabel.text = String(tour.totalDay! as Int)
        costLabel.text = formatCurrency(tour.maxCost! as Double)
        
        let gestureReg = UITapGestureRecognizer()
        gestureReg.addTarget(self, action: #selector(PageItemController.onViewClick(_:)))
        view.addGestureRecognizer(gestureReg)
    }
    
    func onViewClick(sender: UIPanGestureRecognizer) {
        delegate?.pageItemClick(tour)
    }
    
    func formatCurrency(price: Double) -> String{
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "vi_VN")
        return formatter.stringFromNumber(price)!
    }
    
    func setupRatingView() {
        // Required float rating view params
        self.floatRatingView.emptyImage = UIImage(named: "StarEmpty")
        self.floatRatingView.fullImage = UIImage(named: "StarFull")
        // Optional params
        self.floatRatingView.contentMode = UIViewContentMode.ScaleAspectFit
        self.floatRatingView.maxRating = 5  
        self.floatRatingView.minRating = 1
        self.floatRatingView.rating = 2.5
        self.floatRatingView.editable = true
        self.floatRatingView.halfRatings = true
        self.floatRatingView.floatRatings = false
    }
}
