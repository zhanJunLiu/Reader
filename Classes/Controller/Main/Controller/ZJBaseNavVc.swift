//
//  ZJBaseNavVc.swift
//  Scholar
//
//  Created by mac on 16/9/5.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class ZJBaseNavVc: UINavigationController {
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    internal override class func initialize() {
        super.initialize()
        /// 设置导航栏标题
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = ZJGlobalBlueColor()
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    /**
     # 统一所有控制器导航栏左上角的返回按钮
     # 让所有push进来的控制器，它的导航栏左上角的内容都一样
     # 能拦截所有的push操作
     - parameter viewController: 需要压栈的控制器
     - parameter animated:       是否动画
     */
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        /// 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        if viewControllers.count > 0 {
            // push 后隐藏 tabbar
            viewController.hidesBottomBarWhenPushed = true
            let leftButton = UIButton(frame: CGRectMake(0, 0, SCREEN_SCALE_WIDTH * barItemSize, SCREEN_SCALE_HEIGHT * barItemSize))
            leftButton.setImage(UIImage(named: "委员笔记_06"), forState: .Normal)
            leftButton.addTarget(self, action: #selector(navigationBackClick), forControlEvents: .TouchUpInside)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
//            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "委员笔记_06"), style: .Plain, target: self, action: #selector(navigationBackClick))
        }
        super.pushViewController(viewController, animated: true)
    }
    
    /// 返回按钮
    func navigationBackClick() {
//        if CHProgressHUD.isVisible() {
//            CHProgressHUD.dismiss()
//        }
        if UIApplication.sharedApplication().networkActivityIndicatorVisible {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
        popViewControllerAnimated(true)
    }

}