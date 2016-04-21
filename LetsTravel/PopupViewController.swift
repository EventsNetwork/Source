//
//  PopupViewController.swift
//  LetsTravel
//
//  Created by HoangNguyen on 4/21/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

@objc protocol PopupViewControllerDelegate {
    func didSelectPlace(place: Place, section: Int)
}

class PopupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var places = [Place]()
    var section: Int?
    
    weak var delegate: PopupViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "PlaceCell", bundle: nil), forCellReuseIdentifier: "PlaceCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchPlaces()
    }
    
    func fetchPlaces() {
        TravelClient.sharedInstance.searchPlaceViaCategoryAndProvince("1", categoryId: "1", placeName: "", success: { (places: [Place]) in
            self.places = places
            dispatch_async(dispatch_get_main_queue(), { 
                self.tableView.reloadData()
            })
        }) { (error: NSError) in
            
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlaceCell", forIndexPath: indexPath) as! PlaceCell
        cell.place = places[indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let placeSelected = places[indexPath.row]
        delegate?.didSelectPlace(placeSelected, section: section ?? 0)
    }

}
