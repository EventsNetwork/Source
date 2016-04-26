//
//  ToursViewController.swift
//  LetsTravel
//
//  Created by TriNgo on 4/13/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ToursViewController: UIViewController, UIPageViewControllerDataSource {

    private var pageViewController: UIPageViewController?
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let contentImages = ["nature_pic_1.png",
        "nature_pic_2.png",
        "nature_pic_3.png",
        "nature_pic_4.png"];
    
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
        
        
        // Do any additional setup after loading the view.
    }

    private func createPageViewController() {
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        let navigationBarHeight = self.navigationController?.navigationBar.frame.height
        let pageController = self.storyboard?.instantiateViewControllerWithIdentifier("PageController") as! UIPageViewController
        pageController.dataSource = self
        pageController.view.frame = CGRectMake(0, statusBarHeight + navigationBarHeight!, self.view.frame.width, 300)
        
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
    
    @IBAction func onLogoutClick(sender: UIBarButtonItem) {
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
        TravelClient.sharedInstance.logout()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let vc = segue.destinationViewController as? TimelineViewController {
            vc.tourId = tourSelected?.tourId
        }
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
        
        if itemController.itemIndex + 1 < contentImages.count {
            return getItemController(itemController.itemIndex + 1)
        }
        
        return nil
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
    
    // MARK: - Page Indicator
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pageHotTours?.count ?? 0
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

extension ToursViewController: PageItemControllerDelegate {
    func pageItemClick(tour: Tour) {
        tourSelected = tour
        performSegueWithIdentifier("ToTimeLineSegue", sender: nil)
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
        
        cell.posterView.setImageWithURL(NSURL(string: hotTour.imageUrls![0])!)
        
        return cell
    }
}

