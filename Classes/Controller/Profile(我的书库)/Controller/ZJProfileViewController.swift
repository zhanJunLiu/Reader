//
//  ZJProfileViewController.swift
//  Scholar
//
//  Created by mac on 16/9/5.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class ZJProfileViewController: ZJMainVc,UIScrollViewDelegate, ZJMineFooterViewDelegate {
    
    let cellCount = 0
    var segment = UISegmentedControl()
    var scrollView = UIScrollView()
    var segButton1 = UIButton()
    var segButton2 = UIButton()
    var buttonArray = NSMutableArray()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.segment.selectedSegmentIndex = 0
        
        self.navigationController?.navigationBarHidden = false
        
        createSegButton()
        createScrollerView()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//          setupTableView()
        self.view.addSubview(headerView)

        //创建分段控制器
//        createSegment()
        
    }
    
    func yuio() {
        
        scrollView.mj_header.endRefreshing()
    }
    
    
    
    //MARK - 创建分栏button
    func createSegButton() {
        
        let array1 = ["shujia_0_204", "shoucang_621_793"]
        let array2 = ["shujiadianji_0_793", "shoucang_621_204"]
        for i in 0..<2 {
            
            segButton1 = UIButton(type: UIButtonType.Custom)
            segButton1.frame = CGRectMake(SCREEN_W/2 * CGFloat(i), headerView.y + headerView.height, SCREEN_W/2, 44)
            segButton1.setImage(UIImage(named: array1[i]), forState: UIControlState.Normal)
            segButton1.setImage(UIImage(named: array2[i]), forState: UIControlState.Disabled)
            segButton1.tag = i
            
            
            segButton1.addTarget(self, action: #selector(changedValued), forControlEvents: UIControlEvents.TouchUpInside)
            //默认第一个选中
            if i == 0 {
                segButton2 = segButton1
                segButton1.enabled = false
            }
            //            else {
            //                segButton1.selected = false
            //            }
            buttonArray.addObject(segButton1)
            view.addSubview(segButton1)
        }
        
        
    }

    
    //MARK: - 创建分段控制器
    func createSegment() {
        self.segment = UISegmentedControl(frame: CGRectMake(-2, 64 + SCREEN_H / 4 + 4, SCREEN_W+4, 44))
        self.segment.insertSegmentWithTitle("书架", atIndex: 0, animated: true)
        self.segment.insertSegmentWithTitle("收藏", atIndex: 1, animated: true)
        
        //去掉边框颜色
//        self.segment.tintColor = UIColor.clearColor()
        self.segment.tintColor = ZJColor(153, g: 163, b: 175, a: 0.6)
        
        //设置一个字体的字典，内容为没点击的字体大小和颜色
        let unselectedTextAttributes: NSDictionary = [NSFontAttributeName: UIFont.boldSystemFontOfSize(16),NSForegroundColorAttributeName: UIColor ( red: 0.604, green: 0.5857, blue: 0.5528, alpha: 1.0 )];
        self.segment.setTitleTextAttributes(unselectedTextAttributes as[NSObject :AnyObject], forState: UIControlState.Normal)
        //点击之后的字体大小和颜色
//        let selectedTextAttributes: NSDictionary = [NSFontAttributeName: UIFont.boldSystemFontOfSize(16),NSForegroundColorAttributeName: UIColor ( red: 0.3915, green: 0.6216, blue: 1.0, alpha: 1.0 )]
        let selectedTextAttributes: NSDictionary = [NSFontAttributeName: UIFont.boldSystemFontOfSize(16),NSForegroundColorAttributeName: UIColor.redColor()]
        self.segment.setTitleTextAttributes(selectedTextAttributes as[NSObject :AnyObject], forState: UIControlState.Selected)
        
        
        self.segment.addTarget(self, action: #selector(changedValued), forControlEvents: UIControlEvents.ValueChanged)
        
        self.view.addSubview(self.segment)
        
        self.segment.selectedSegmentIndex = 0
    }
    
    @objc private func changedValued(button: UIButton) {
        
        segButton2.enabled = true
        button.enabled = false
        segButton2 = button
        self.scrollView.contentOffset = CGPointMake(CGFloat(segButton2.tag) * SCREEN_W, 0)
        
    }
    
    //MARK: - 创建scrollerView
    func createScrollerView() {
        
        self.scrollView = UIScrollView(frame: CGRectMake(0, self.segButton1.y+self.segButton1.height, SCREEN_W, SCREEN_H - (SCREEN_W / 4 + self.segButton1.height + 64)))
        self.scrollView.delegate = self
        self.scrollView.pagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        
        self.scrollView.bounces = false
        self.view.addSubview(self.scrollView)

        self.scrollView.contentSize = CGSizeMake(SCREEN_W, 0)
        self.scrollView.addSubview(footerView)
        self.scrollView.addSubview(footerView2)
        
        //初始化子控制器
        let bookStore = DDBookStoreViewController()
        let collectBook = DDCollectViewController()
        
        let bookArray = [bookStore, collectBook]
        
        for item in 0..<bookArray.count {
            let vc = bookArray[item]
            vc.view.frame = CGRectMake(CGFloat(item) * SCREEN_W, 0, SCREEN_W, self.scrollView.height)

            if ZJAccountModel.isLogin() {
                self.scrollView.addSubview(vc.view)
                self.addChildViewController(vc)
            }
        }
    }
    
    
    //MARK: - 反向关联segment
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / SCREEN_W
        self.segment.selectedSegmentIndex = Int(index)
        
    }
    
    private lazy var headerView: ZJMineHeaderView = {
        let headerView = ZJMineHeaderView()
        
        headerView.frame = CGRectMake(0, 64, SCREEN_W, SCREEN_H / 4)
        headerView.iconButton.addTarget(self, action: #selector(iconButtonClick), forControlEvents: .TouchUpInside)
        headerView.messageButton.addTarget(self, action: #selector(messageButtonClick), forControlEvents: .TouchUpInside)
        headerView.settingButton.addTarget(self, action: #selector(settingButtonClick), forControlEvents: .TouchUpInside)
        return headerView
    }()
    
    // MARK: - 头部按钮点击
    func iconButtonClick() {
        /** 头像按钮 */
        print("iconButton -> ")
        // 判断是否登录
        if ZJAccountModel.isLogin() {
            
            print("打印头像: \(ZJAccountModel.shareAccount()?.avatar)")
            
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
          
            let cameraAction = UIAlertAction(title: "编辑资料", style: .Default, handler: { (_) in
                
                let settingUserVC = MTUserInfoViewControllerNEW()
                settingUserVC.delegate = self
                self.navigationController?.pushViewController(settingUserVC, animated: true)
            })
//            let photoAction = UIAlertAction(title: "退出登录", style: .Destructive, handler: { (_) in
////                NSUserDefaults.standardUserDefaults().setBool(false, forKey: isLogin)
//                
//                ZJAccountModel.logout()
//                self.headerView.iconButton.setImage(UIImage(named: "占位图"), forState: .Normal)
//                CHProgressHUD.showInfoWithStatus("已退出当前账号")
//            })
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            actionSheet.addAction(cancelAction)
            actionSheet.addAction(cameraAction)
//            actionSheet.addAction(photoAction)
            self.presentViewController(actionSheet, animated: true, completion: nil)
        } else {
            let settingUserVC = ZJLoginViewController()
            self.navigationController?.pushViewController(settingUserVC, animated: true)
        }
    }
    
    func messageButtonClick() {
        print("messageButton -> ")
        if ZJAccountModel.isLogin() {
            let messageVC = ZJMyNotesViewController()
            messageVC.title = "我的笔记"
            navigationController?.pushViewController(messageVC, animated: true)
        }else {
            let settingUserVC = ZJLoginViewController()
            self.navigationController?.pushViewController(settingUserVC, animated: true)
        }
    }
    
    func settingButtonClick() {
        print("settingButton -> ")
        let settingVC = ZJSettingViewController()
        settingVC.title = "设置"
        navigationController?.pushViewController(settingVC, animated: true)
    }
    
    private lazy var footerView: ZJMineFooterView = {
        let footerView = ZJMineFooterView()
        footerView.frame = CGRectMake(0, 0, SCREEN_W, 400)
        footerView.delegate = self
        return footerView
    }()
    
    private lazy var footerView2: ZJMineFooterView = {
        let footerView = ZJMineFooterView()
        footerView.frame = CGRectMake(SCREEN_W, 0, SCREEN_W, 400)
        footerView.delegate = self
        return footerView
    }()
    
    func didClickFooterButton() {
        if ZJAccountModel.isLogin() {
            let vc = MTUserInfoViewControllerNEW()
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            let settingUserVC = ZJLoginViewController()
            self.navigationController?.pushViewController(settingUserVC, animated: true)
        }
    }
    
    /** 更新头部视图 */
//    func updateHeaderData() {
//        headerView.iconButton.yy_setImageWithURL(NSURL(string: "\(ZJAccountModel.shareAccount()?.avatar ?? "")"), forState: .Normal, placeholder: UIImage(named: ""))
//        headerView.nameLabel.text = ZJAccountModel.shareAccount()!.nickname!
//    }
}

extension ZJProfileViewController: MTUserInfoViewControllerNEWDelegate {
    
    func userInfoName(nickName: String) {
        print("nick -> \(nickName)")
        headerView.nameLabel.text = nickName
    }
    
    func userInfoImage(imgName: UIImage) {
        print("icon -> \(imgName)")
        headerView.iconButton.setImage(imgName, forState: .Normal)
    }
}

