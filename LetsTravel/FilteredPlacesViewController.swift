//
//  FilteredPlacesViewController.swift
//  LetsTravel
//
//  Created by HoangNguyen on 4/20/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

@objc protocol FilteredPlacesViewControllerDelegate {
    func selectPlacesDone(places: [Place])
}

class FilteredPlacesViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var settingsButton: UIButton!
    
    weak var delegate: FilteredPlacesViewControllerDelegate?
    
    var places = [Place]()
    var placesSelected = [Place]()
    
    var categories = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        for cate in PlaceOption.allValues {
            categories.append(String(cate))
        }
        
        fetchPlaces()
    }
    
    func fetchPlaces() {
        TravelClient.sharedInstance.getPlaces({ (places: [Place]) in
            self.places = places
            self.tableView.reloadData()
        }) { (error: NSError) in
            
        }
        
        TravelClient.sharedInstance.searchPlaceViaCategoryAndProvince("1", categoryId: "1", placeName: "", success: { (places: [Place]) in
            print(places)
        }) { (error: NSError) in
            
        }
    }
    
    // MARK: UITableViewDelegate, UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlaceCell") as! PlaceCell
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let place = places[indexPath.row]
        placesSelected.append(place)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        placesSelected.removeAtIndex(indexPath.row)
    }
    
    // MARK: UISearchBarDelegate
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
    }

    @IBAction func settingsClick(sender: UIButton) {
        ActionSheetStringPicker.showPickerWithTitle("Categories", rows: categories, initialSelection: 0, doneBlock: { (picker:ActionSheetStringPicker!, selectedIndex: Int, selectedValue: AnyObject!) in
            
        }, cancelBlock: { (picker: ActionSheetStringPicker!) in
                
        }, origin: sender)
    }
    
    @IBAction func cancelClick(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func doneClick(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true) { 
            self.delegate?.selectPlacesDone(self.placesSelected)
        }
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
