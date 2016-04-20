//
//  PageItemController.swift
//  LetsTravel
//
//  Created by TriNgo on 4/17/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

class PageItemController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var totalDayLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    // MARK: - Variables
    var desc: String = ""
    var totalDay: String = ""
    var cost: String = ""
    var itemIndex: Int = 0
    var imageName: String = "" {
        didSet {
            if let imageView = imageView {
                imageView.image = UIImage(named: imageName)
            }
        }
    }
    
//    var desc: String = "" {
//        didSet {
//            if let descriptionLabel = descriptionLabel {
//                descriptionLabel.text = desc
//            }
//        }
//    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView!.image = UIImage(named: imageName)
        descriptionLabel.text = desc
        totalDayLabel.text = totalDay
        costLabel.text = cost
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
