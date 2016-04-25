//
//  ProvincesViewController.swift
//  LetsTravel
//
//  Created by TriNgo on 4/21/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

class ProvincesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl : UIRefreshControl!
    var searchBar: UISearchBar!
    var provinces: [Province]!
    var filterProvinces: [Province]!
    
    var selectedProvince: Province?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action:"loadDataFromNetwork:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        dispatch_async(dispatch_get_main_queue()) {
            self.loadDataFromNetwork(self.refreshControl)
        }

        // Do any additional setup after loading the view.
    }
    
    func loadDataFromNetwork(refreshControl: UIRefreshControl? = nil) {
        
        refreshControl!.beginRefreshing()
        TravelClient.sharedInstance.getProvinces({ (response:[Province]) in
            self.provinces = response
            self.tableView.reloadData()
            if refreshControl != nil {
                refreshControl!.endRefreshing()
            }
        }) { (error: NSError) in
            print(error.localizedDescription)
            if refreshControl != nil {
                refreshControl!.endRefreshing()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let vc = segue.destinationViewController as! TimelineViewController
        vc.province = selectedProvince
    }
    

}

// Search Bar methods
extension ProvincesViewController: UISearchBarDelegate{
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filterProvinces = provinces?.filter({(Province) -> Bool in
            let searchField : NSString = Province.provinceName as! String
            let range = searchField.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        
        self.tableView.reloadData()
    }
    
}


extension ProvincesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provinces?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProvinceCell", forIndexPath: indexPath) as! ProvinceCell
        cell.selectionStyle = .None
        
        let province: Province
        if filterProvinces != nil {
            province = filterProvinces[indexPath.row]
        } else {
            province = provinces[indexPath.row]
        }
        
        
        cell.posterView.setImageWithURL(NSURL(string: province.imageUrls![0] as String)!, placeholderImage: UIImage(named: "placeholder"))
        cell.provinceName.text = province.provinceName as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let province = provinces[indexPath.row]
        selectedProvince = province
        performSegueWithIdentifier("toTimelineSegue", sender: nil)
    }
    
}









