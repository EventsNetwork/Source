//
//  TimelineViewController.swift
//  LetsTravel
//
//  Created by TriNgo on 4/13/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class TimeLineTableView: UITableView {
    
}

class TimelineViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateStartTextField: UITextField!
    
    var placesToGo = [[Place]]()
    
    var currentSection = 0

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
    
    @IBAction func dateStartClick(sender: UITextField) {
        ActionSheetDatePicker.showPickerWithTitle("", datePickerMode: UIDatePickerMode.Date, selectedDate: NSDate(), doneBlock: { (picker: ActionSheetDatePicker!, selectedDate: AnyObject!, textField: AnyObject!) in
            let selectedDate = selectedDate as! NSDate
            let dateFormatter = NSDateFormatter()
            dateFormatter.locale = NSLocale.currentLocale()
            dateFormatter.dateFormat = "EE dd/MM/yyyy"
            self.dateStartTextField.text = dateFormatter.stringFromDate(selectedDate)
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
        tableView.separatorColor = UIColor.whiteColor()
        
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
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
//        cell.contentView.backgroundColor = UIColor.clearColor()
//        
//        var whiteRoundedCornerView:UIView!
//        whiteRoundedCornerView = UIView(frame: CGRectMake(5, 10, self.view.bounds.width-10, 120))
//        whiteRoundedCornerView.backgroundColor = UIColor.lightGrayColor()
//        //whiteRoundedCornerView.backgroundColor = UIColor(red: 174/255.0, green: 174/255.0, blue: 174/255.0, alpha: 1.0)
//        whiteRoundedCornerView.layer.masksToBounds = false
//        
//        whiteRoundedCornerView.layer.shadowOpacity = 1.55;
//        
//        whiteRoundedCornerView.layer.shadowOffset = CGSizeMake(1, 0);
//        
//        whiteRoundedCornerView.layer.shadowColor = UIColor.lightGrayColor().CGColor
//        
//        //whiteRoundedCornerView.layer.shadowColor = UIColor(red: 53/255.0, green: 143/255.0, blue: 185/255.0, alpha: 1.0).CGColor
//        
//        whiteRoundedCornerView.layer.cornerRadius = 3.0
//        whiteRoundedCornerView.layer.shadowOffset = CGSizeMake(-1, -1)
//        whiteRoundedCornerView.layer.shadowOpacity = 0.5
//        
//        cell.contentView.addSubview(whiteRoundedCornerView)
//        cell.contentView.sendSubviewToBack(whiteRoundedCornerView)
        
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
        //popoverVC?.sourceRect = CGRect(x: 0, y: cell.frame.origin.y, width: 1, height: 1)
        
        vc.section = indexPath.section
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
