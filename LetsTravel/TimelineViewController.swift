//
//  TimelineViewController.swift
//  LetsTravel
//
//  Created by TriNgo on 4/13/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class TimelineViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateStartTextField: UITextField!
    
    var placesToGo = [[Place]]()
    
    var currentSection = 0
    var province: Province?
    
    var startTime: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateStartTextField.delegate = self
        
        placesToGo.append([])
        
        initTableView()
    }
    
    @IBAction func addDayClick(sender: UIButton) {
        placesToGo.append([])
        tableView.reloadData()
    }
    
    @IBAction func doneClick(sender: UIBarButtonItem) {
        let tour = Tour()
        tour.startTime = startTime
        tour.provinceId = province?.provinceId
        var events = [TourEvent]()
        for (index, places) in placesToGo.enumerate() {
            for place in places {
                let event = TourEvent()
                event.dayOrder = index + 1
                event.placeId = place.placeId
                events.append(event)
            }
        }
        tour.tourEvents = events
        TravelClient.sharedInstance.createTour(tour, success: { (tour: Tour) in
            print("success")
        }) { (error: NSError) in
            
        }
    }
    @IBAction func dateStartClick(sender: UITextField) {
        ActionSheetDatePicker.showPickerWithTitle("", datePickerMode: UIDatePickerMode.Date, selectedDate: NSDate(), doneBlock: { (picker: ActionSheetDatePicker!, selectedDate: AnyObject!, textField: AnyObject!) in
            let selectedDate = selectedDate as! NSDate
            let dateFormatter = NSDateFormatter()
            dateFormatter.locale = NSLocale.currentLocale()
            dateFormatter.dateFormat = "EE dd/MM/yyyy"
            self.dateStartTextField.text = dateFormatter.stringFromDate(selectedDate)
            
            self.startTime = Int(selectedDate.timeIntervalSince1970)
        }, cancelBlock: { (picker: ActionSheetDatePicker!) in
                
        }, origin: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
}

extension TimelineViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return false
    }
}

extension TimelineViewController: UITableViewDataSource {
    func initTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        tableView.separatorColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        
        tableView.tableFooterView = UIView()
        
        let inset = UIEdgeInsetsMake(0, 20, 0, 20);
        tableView.contentInset = inset;
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
            let cell = tableView.dequeueReusableCellWithIdentifier("PlaceTimelineCell", forIndexPath: indexPath) as! PlaceTimelineCell
            cell.delegate = self
            cell.place = placesToGo[indexPath.section][indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("CreatePlaceCell", forIndexPath: indexPath) as! CreatePlaceCell
            cell.hideOptions()
            cell.delegate = self
            return cell
        }
    }
    
}

extension TimelineViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = PlaceTimelineSection(section: section, frame: CGRectMake(0, 0, tableView.frame.size.width, 25))
        view.delegate = self
        return view;
    }
}

extension TimelineViewController: CreatePlaceCellDelegate, UIPopoverPresentationControllerDelegate, PopupViewControllerDelegate {
    func choosePlaceOption(cell: UITableViewCell, sender: UIButton) {
        
        let vc = PopupViewController(nibName: "PopupViewController", bundle: nil)
        vc.modalPresentationStyle = .Popover
        vc.preferredContentSize = CGSizeMake(300, 300)
        
        let indexPath = tableView.indexPathForCell(cell)!
        
        let popoverVC = vc.popoverPresentationController
        
        popoverVC?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        popoverVC?.delegate = self
        popoverVC?.sourceView = cell
        
        vc.section = indexPath.section
        vc.province = province
        vc.delegate = self
        
        presentViewController(vc, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    func didSelectPlace(place: Place, section: Int) {
        if placesToGo.count == 0 {
            placesToGo.append([place])
            tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
        } else {
            placesToGo[section].append(place)
            tableView.reloadSections(NSIndexSet(index: section), withRowAnimation: .Automatic)
        }
        
        self.presentedViewController?.dismissViewControllerAnimated(true, completion: nil)
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
