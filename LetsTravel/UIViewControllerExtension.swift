//
//  UIViewControllerExtension.swift
//  LetsTravel
//
//  Created by HoangNguyen on 4/26/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    func showLoading() {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    }
    func hideLoading() {
        MBProgressHUD.hideHUDForView(self.view, animated: true)
    }
}
