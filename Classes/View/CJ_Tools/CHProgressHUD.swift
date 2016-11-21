//
//  CHProgressHUD.swift
//  TestNetworking
//
//  Created by mac on 16/9/17.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
import SVProgressHUD

class CHProgressHUD: NSObject {
    
    class func setupHUD() {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.Custom)
        SVProgressHUD.setForegroundColor(UIColor.whiteColor())
        SVProgressHUD.setBackgroundColor(UIColor(white: 0.0, alpha: 0.8))
        SVProgressHUD.setFont(UIFont.boldSystemFontOfSize(16))
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
    }
    
    class func show() {
        SVProgressHUD.show()
    }
    
    // 和网络数据相关
    class func showWithStatus(status: String) {
        SVProgressHUD.showWithStatus(status)
    }
    
    class func showInfoWithStatus(status: String) {
        SVProgressHUD.showInfoWithStatus(status)
    }
    
    class func showSuccessWithStatus(status: String) {
        SVProgressHUD.showSuccessWithStatus(status)
    }
    
    class func showErrorWithStatus(status: String) {
        SVProgressHUD.showErrorWithStatus(status)
    }
    
    class func dismiss() {
        SVProgressHUD.dismiss()
    }

}
