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
        let navigationController = segue.destinationViewController as! UINavigationController
        let vc = navigationController.viewControllers[0] as! FilteredPlacesViewController
        vc.delegate = self
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
            let cell = tableView.dequeueReusableCellWithIdentifier("PlaceTimelineCell") as! PlaceTimelineCell
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("CreatePlaceCell") as! CreatePlaceCell
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.contentView.backgroundColor = UIColor.clearColor()
        
        var whiteRoundedCornerView:UIView!
        whiteRoundedCornerView = UIView(frame: CGRectMake(5, 10, self.view.bounds.width-10, 120))
        whiteRoundedCornerView.backgroundColor = UIColor.lightGrayColor()
        //whiteRoundedCornerView.backgroundColor = UIColor(red: 174/255.0, green: 174/255.0, blue: 174/255.0, alpha: 1.0)
        whiteRoundedCornerView.layer.masksToBounds = false
        
        whiteRoundedCornerView.layer.shadowOpacity = 1.55;
        
        whiteRoundedCornerView.layer.shadowOffset = CGSizeMake(1, 0);
        
        whiteRoundedCornerView.layer.shadowColor = UIColor.lightGrayColor().CGColor
        
        //whiteRoundedCornerView.layer.shadowColor = UIColor(red: 53/255.0, green: 143/255.0, blue: 185/255.0, alpha: 1.0).CGColor
        
        whiteRoundedCornerView.layer.cornerRadius = 3.0
        whiteRoundedCornerView.layer.shadowOffset = CGSizeMake(-1, -1)
        whiteRoundedCornerView.layer.shadowOpacity = 0.5
        
        cell.contentView.addSubview(whiteRoundedCornerView)
        cell.contentView.sendSubviewToBack(whiteRoundedCornerView)
        
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