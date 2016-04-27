//
//  MyTourViewController.swift
//  LetsTravel
//
//  Created by TriNgo on 4/26/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

class MyTourViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataView: UIView!
    
    var refreshControl : UIRefreshControl!
    var searchBar: UISearchBar!
    var myTours: [Tour]!
    var selectedTour: Tour!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action:"loadDataFromNetwork:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        tableView.hidden = false
        noDataView.hidden = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        dispatch_async(dispatch_get_main_queue()) {
            self.loadDataFromNetwork(self.refreshControl)
        }
    }
    
    func loadDataFromNetwork(refreshControl: UIRefreshControl? = nil) {
        
        refreshControl!.beginRefreshing()
        TravelClient.sharedInstance.getMyTours({ (response:[Tour]) in
            self.myTours = response
            self.tableView.reloadData()
            if refreshControl != nil {
                refreshControl!.endRefreshing()
            }
            if self.myTours.count != 0 {
                self.tableView.hidden = false
                self.noDataView.hidden = true // disappear
            } else {
                self.tableView.hidden = true
                self.noDataView.hidden = false // appear
            }
        }) { (error: NSError) in
            self.tableView.hidden = true
            self.noDataView.hidden = false
            print(error.localizedDescription)
            if refreshControl != nil {
                refreshControl!.endRefreshing()
            }
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? TimelineViewController {
            vc.tourId = selectedTour?.tourId
        }
    }
 

}

extension MyTourViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTours?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyTourCell", forIndexPath: indexPath) as! MyTourCell
        cell.selectionStyle = .None
        
        let myTour = myTours[indexPath.row]
        cell.tour = myTour
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let myTour = myTours[indexPath.row]
        selectedTour = myTour
        performSegueWithIdentifier("toTimelineSegue", sender: nil)
    }
    
}