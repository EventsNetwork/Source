//
//  TimelineViewController.swift
//  LetsTravel
//
//  Created by TriNgo on 4/13/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var placesToGo = [[Place]]()
    
    var currentSection = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        placesToGo.append([])
        
        initTableView()
    }
    
    @IBAction func addDayClick(sender: UIButton) {
        placesToGo.append([])
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let vc = navigationController.viewControllers[0] as! FilteredPlacesViewController
        vc.delegate = self
    }
}

extension TimelineViewController: UITableViewDataSource {
    func initTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let sections = placesToGo.count > 0 ? placesToGo.count : 0
        return sections
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if placesToGo.count > 0 && placesToGo[section].count > 0 {
            return placesToGo[section].count + 1
        } else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if placesToGo.count > indexPath.section && placesToGo[indexPath.section].count > indexPath.row {
            let cell = tableView.dequeueReusableCellWithIdentifier("PlaceTimelineCell") as! PlaceTimelineCell
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("CreatePlaceCell") as! CreatePlaceCell
            cell.delegate = self
            return cell
        }
    }
    
}

extension TimelineViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = PlaceTimelineSection(section: section, frame: CGRectMake(0, 0, tableView.frame.size.width, 30))
        view.delegate = self
        return view;
    }
}

extension TimelineViewController: CreatePlaceCellDelegate {
    func choosePlaceOption(cell: UITableViewCell) {
        let indexPath = tableView.indexPathForCell(cell)!
//        let place = Place(name: "", categoryId: 0, minPrice: 0, maxPrice: 0, address: "", desc: "", latitude: 0, longitude: 0, provinceId: 0)
//        if placesToGo.count == 0 {
//            placesToGo.append([place])
//            tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
//        } else {
//            placesToGo[indexPath.section].append(place)
//            tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: .Automatic)
//        }
        currentSection = indexPath.section
        performSegueWithIdentifier("timelineFilterModalSegue", sender: nil)
        
    }
}

extension TimelineViewController: PlaceTimelineSectionDelegate {
    func removeClicK(section: Int) {
        placesToGo.removeAtIndex(section)
        tableView.reloadData()
    }
}

extension TimelineViewController: PlaceTimelineCellDelegate {
    func placeRemove(cell: UITableViewCell) {
        let indexPath = tableView.indexPathForCell(cell)!
        placesToGo[indexPath.section].removeAtIndex(indexPath.row)
        let sections = NSIndexSet(index: indexPath.section)
        tableView.reloadSections(sections, withRowAnimation: UITableViewRowAnimation.Automatic)
    }
}

extension TimelineViewController: FilteredPlacesViewControllerDelegate {
    func selectPlacesDone(places: [Place]) {
        placesToGo[currentSection].appendContentsOf(places)
        //tableView.reloadData()
        tableView.reloadSections(NSIndexSet(index: currentSection), withRowAnimation: .Automatic)
    }
}