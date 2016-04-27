//
//  ToursViewController.swift
//  LetsTravel
//
//  Created by TriNgo on 4/13/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ToursViewController: UIViewController {

    private var pageViewController: UIPageViewController?
    @IBOutlet weak var collectionView: UICollectionView!
    
//    private let contentImages = ["nature_pic_1.png",
//        "nature_pic_2.png",
//        "nature_pic_3.png",
//        "nature_pic_4.png"];

    private var timer: NSTimer = NSTimer()
    private var hotTours: [Tour]?
    private var pageHotTours: [Tour]?
    private var collectionHotTours: [Tour]?
    private var tourSelected: Tour?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        hotTours = [Tour]()
        pageHotTours = [Tour]()
        collectionHotTours = [Tour]()
        
        createPageViewController()
        setupPageControl()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(ToursViewController.advancePage), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }

    private func createPageViewController() {
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        let navigationBarHeight = self.navigationController?.navigationBar.frame.height
        let pageController = self.storyboard?.instantiateViewControllerWithIdentifier("PageController") as! UIPageViewController
        pageController.dataSource = self
        pageController.view.frame = CGRectMake(0, statusBarHeight + navigationBarHeight!, self.view.frame.width, 240)
        
        loadData(pageController)
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
        
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = UIColor.greenColor()
        appearance.backgroundColor = UIColor.whiteColor()
    }
    
    private func loadData(pageController: UIPageViewController) {
        TravelClient.sharedInstance.getHotTours({ (response:[Tour]) -> () in

            self.hotTours = response
            
            for i in 0 ..< 4 {
                let tour = self.hotTours![i]
                self.pageHotTours?.append(tour)
            }
            
            for j in 4 ..< 10 {
                let tour = self.hotTours![j]
                self.collectionHotTours?.append(tour)
            }
            
            if self.pageHotTours!.count > 0 {
                let firstController = self.getItemController(0)!
                let startingViewControllers: NSArray = [firstController]
                pageController.setViewControllers(startingViewControllers as? [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
            }
            
            self.collectionView.reloadData()
        }, failure: { (error: NSError) -> () in
            print(error.localizedDescription)
        })
    }
    
    func advancePage () {
        let pvcs = pageViewController?.childViewControllers as! [PageItemController]
        var itemIndex = pvcs[0].itemIndex
        if itemIndex < (pageHotTours?.count)! - 1 {
            itemIndex = itemIndex + 1
        } else {
            itemIndex = 0
        }
        let firstController = getItemController(itemIndex)!
        let startingViewControllers = [firstController]
        pageViewController!.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
    }
    
    @IBAction func onLogoutClick(sender: UIBarButtonItem) {
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
        TravelClient.sharedInstance.logout()
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? TimelineViewController {
            vc.tourId = tourSelected?.tourId
        }
    }

    
    private func getItemController(itemIndex: Int) -> PageItemController? {
        
        if itemIndex < pageHotTours!.count {
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("ItemController") as! PageItemController
            pageItemController.itemIndex = itemIndex
            pageItemController.imageName = pageHotTours![itemIndex].imageUrls![0]
            
            let hotTour = pageHotTours![itemIndex]
            
            //pageItemController.desc = hotTour.desc!
            //pageItemController.totalDay = String(hotTour.totalDay! as Int)
            //pageItemController.cost = String(hotTour.maxCost! as Double)
            
            pageItemController.tour = hotTour
            pageItemController.delegate = self
            
            return pageItemController
        }
        
        return nil
    }
    
    func randomIndex(count: Int) -> Int {
        return Int(arc4random_uniform(UInt32(count)))
    }
}

extension ToursViewController: PageItemControllerDelegate, UIPageViewControllerDataSource {
    func pageItemClick(tour: Tour) {
        tourSelected = tour
        performSegueWithIdentifier("ToTimeLineSegue", sender: nil)
    }
    
    // MARK: - UIPageViewControllerDataSource
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
        
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex - 1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
        
        if itemController.itemIndex + 1 < pageHotTours!.count {
            return getItemController(itemController.itemIndex + 1)
        }
        
        return nil
    }

}

extension ToursViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Set the number of items in your collection view.
        return collectionHotTours?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HotTourCell", forIndexPath: indexPath) as! HotTourCell
        let hotTour = collectionHotTours![indexPath.row]
        let count = hotTour.imageUrls?.count
        let random = randomIndex(count!)
        
        cell.posterView.setImageWithURL(NSURL(string: hotTour.imageUrls![random])!)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        tourSelected = collectionHotTours![indexPath.row]
        performSegueWithIdentifier("ToTimeLineSegue", sender: nil)
    }
}

