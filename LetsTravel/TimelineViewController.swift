//
//  TimelineViewController.swift
//  LetsTravel
//
//  Created by TriNgo on 4/13/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import FBSDKShareKit

class TimelineViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateStartTextField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var addDateButton: UIButton!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var placesToGo = [[Place]]() {
        didSet {
            let price = totalPrice
            let priceStr = Utils.fromPriceToString(price)
            totalLabel.text = priceStr + " VND"
        }
    }
    
    var totalPrice: Double! {
        var total: Double = 0
        for places in placesToGo {
            for place in places {
                let minPrice: Double = place.minPrice ?? 0
                let maxPrice: Double = place.maxPrice ?? 0
                total += (minPrice + maxPrice)/2
            }
        }
        return total
    }
    
    var tourId: Int?
    
    var currentSection = 0
    
    var startTime: Int?
    var selectedDate: NSDate?

    var province: Province? {
        didSet{
            self.navigationItem.title = province!.provinceName! as String
        }
    }
    
    let timelineHelpers = TimeLineHelpers()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateStartTextField.delegate = self
        
        if tourId != nil {
            addDateButton.hidden = true
            dateStartTextField.enabled = false
            doneButton.title = "Clone"
            TravelClient.sharedInstance.getTourDetail(tourId!, success: { (tour: Tour) in
                self.placesToGo =  self.timelineHelpers.getPlacesFromTour(tour)
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
                
            }, failure: { (error: NSError) in
                print(error)
            })
        } else {
            placesToGo.append([])
        }
        
        initTableView()
    }
    
    @IBAction func addDayClick(sender: UIButton) {
        placesToGo.append([])
        tableView.reloadData()
        let indexPath = NSIndexPath(forRow: 0, inSection: placesToGo.count - 1)
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    @IBAction func doneClick(sender: UIBarButtonItem) {
        if tourId == nil {
            let tour = timelineHelpers.fromPlacesToTour(placesToGo, startTime: startTime ?? 0, province: province)
            
            showLoading()
            TravelClient.sharedInstance.createTour(tour, success: { (tour: Tour) in
                self.hideLoading()
                
                self.handleLocalPushNotification(tour)
                
                Alert.confirm("Create tour success", message: "Your tour has been created. Do you want to share it on FB ?", controller: self, done: {
                    self.generateFBShare(tour)
                })
            }) { (error: NSError) in
                
            }
        }
    }
    
    @IBAction func dateStartClick(sender: UITextField) {
        
        ActionSheetDatePicker.showPickerWithTitle("", datePickerMode: UIDatePickerMode.DateAndTime, selectedDate: NSDate(), doneBlock: { (picker: ActionSheetDatePicker!, selectedDate: AnyObject!, textField: AnyObject!) in
            self.selectedDate = selectedDate as? NSDate
            self.dateStartTextField.text = Utils.dateTotring(self.selectedDate!, format: "EE dd/MM/yyyy hh:mm")
            
            self.startTime = Int(selectedDate.timeIntervalSince1970)
        }, cancelBlock: { (picker: ActionSheetDatePicker!) in
                
        }, origin: sender)
    }
    
    func generateFBShare(tour: Tour) {
        
        TravelClient.sharedInstance.generateShareUrl(tour, success: { (hostlink: FBHostLink) in
            dispatch_async(dispatch_get_main_queue(), { 
                self.shareToFB(hostlink)
            })
        }) { (error: NSError) in
            
        }
    }
    
    func shareToFB(hostlink: FBHostLink) {
        let content = FBSDKShareLinkContent()
        content.contentTitle = "Travel"
        content.contentDescription = "Travel"
        content.contentURL = NSURL(string: hostlink.canonical_url ?? "")
        
        FBSDKShareDialog.showFromViewController(self, withContent: content, delegate: nil)
    }
    
    func handleLocalPushNotification(tour: Tour) {
        let fireDate = selectedDate?.dateByAddingTimeInterval(-(60 * 60 * 24))
        
        let notification = UILocalNotification()
        notification.alertBody = "Time to go, prepare now!"
        notification.alertAction = "Open"
        notification.fireDate = fireDate
        
        let tourId: String
        
        if let id = tour.tourId {
           tourId = String(id)
        } else {
            tourId = NSUUID().UUIDString
        }
        
        notification.userInfo = ["tourId": tourId]
        notification.category = "Tour"
        notification.soundName = UILocalNotificationDefaultSoundName
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
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
        
        tableView.registerClass(PlaceTimelineSection.self, forHeaderFooterViewReuseIdentifier: "PlaceTimeLineHeader")
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let sections = placesToGo.count > 0 ? placesToGo.count : 0
        return sections
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tourId != nil {
            if placesToGo.count > 0 && placesToGo[section].count > 0 {
                return placesToGo[section].count
            } else {
                return 0
            }
        } else {
            if placesToGo.count > 0 && placesToGo[section].count > 0 {
                return placesToGo[section].count + 1
            } else {
                return 1
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if placesToGo.count > indexPath.section && placesToGo[indexPath.section].count > indexPath.row {
            let cell = tableView.dequeueReusableCellWithIdentifier("PlaceTimelineCell", forIndexPath: indexPath) as! PlaceTimelineCell
            cell.delegate = self
            cell.place = placesToGo[indexPath.section][indexPath.row]
            
            if tourId != nil {
                cell.removeButton.hidden = true
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("CreatePlaceCell", forIndexPath: indexPath) as! CreatePlaceCell
            cell.hideOptions()
            cell.delegate = self
            return cell
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let nav = segue.destinationViewController as! UINavigationController
        let vc = nav.topViewController as! PlaceDetailViewController
        
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        
        vc.placeId = placesToGo[indexPath!.section][indexPath!.row].placeId
        
    }
    
}

extension TimelineViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hideCloseButton: Bool
        if tourId != nil {
            hideCloseButton = true
        } else {
            hideCloseButton = false
        }
        let view = tableView.dequeueReusableHeaderFooterViewWithIdentifier("PlaceTimeLineHeader") as! PlaceTimelineSection
        
        view.hideCloseButton = hideCloseButton
        view.delegate = self
        view.section = section
        
        return view;
    }
}

extension TimelineViewController: CreatePlaceCellDelegate, UIPopoverPresentationControllerDelegate, PopupViewControllerDelegate {
    
    func choosePlaceOption(cell: UITableViewCell, sender: UIButton, categoryId:Int) {
        showPopup(cell, categoryId: categoryId)
    }
    
    func showPopup(cell: UITableViewCell, categoryId: Int) {
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
        vc.categoryId = categoryId
        
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
        
        let rowIndex = placesToGo[section].count
        
        let indexPath = NSIndexPath(forRow: rowIndex, inSection: section)
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
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
