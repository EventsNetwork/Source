//
//  PlaceDetailViewController.swift
//  LetsTravel
//
//  Created by TriNgo on 4/13/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit
import Cosmos

class PlaceDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var costView: UIView!
    @IBOutlet weak var descriptionView: UIView!
    
    @IBOutlet weak var placeNameLabel: UILabel!
    
    @IBOutlet weak var costLabel: UILabel!
    var placeId:Int! {
        didSet{
            
        }
    }
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var starRating: CosmosView!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        TravelClient.sharedInstance.getPlaceDetail(placeId, success: { (place:Place) -> () in
            
                self.posterImage.setImageWithURL(NSURL(string: place.imageUrls![0])!)
                self.placeNameLabel.text = place.name
                self.descLabel.text = place.desc
                self.costLabel.text = "From " + Utils.fromPriceToString(place.minPrice!)
            
                self.starRating.rating = Double(place.rating!)
                self.addressLabel.text = place.address!
            
            }) { (error: NSError) -> () in
                print(error.localizedDescription)
        }
    }
    
    
    
    private func initView() {
        let scrollViewHeight = posterImage.frame.size.height + costView.frame.size.height + descriptionView.frame.size.height
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: scrollViewHeight)
        
//        scrollView.frame = CGRect(origin: scrollView.frame.origin, size: CGSize(width: scrollView.frame.size.width, height: scrollViewHeight))
//        
//        view.setNeedsLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        initView()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onClose(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
