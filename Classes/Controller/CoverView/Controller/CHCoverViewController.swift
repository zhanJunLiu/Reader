//
//  CHCoverViewController.swift
//  CHReadingBook
//
//  Created by mac on 2016/10/18.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
import Alamofire

class CHCoverViewController: UIViewController {
    
    /// MARK: -对外接口
    var imageName:      String!  /** 图书封面 */
    
    var titles:         String!  /** 书名 */
    
    var author:         String!  /** 作者 */
    
    var readingCount:   String!  /** 阅读人数 */
    
    var fileSize:       String!  /** 文件大小 */
    
    var descriptions:   String!  /** 图书简介 */
    
    var money:          String!  /** 图书价格 */
    
    var readingURL:     String!  /** 读书的url */
    
    var percent:        Float! /** 下载进度 */
    
    var coverViews: ZJCoverView?
    
    var progressV: ZJProgress?
    
    private var dataPath: String?
    
    //图书id
    var bookid:         String!
    
    private lazy var progress: UIProgressView = {
        let progress = UIProgressView()
        progress.backgroundColor = UIColor.whiteColor()
        return progress
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let coverView = ZJCoverView(frame: self.view.bounds, imageName: imageName, title: titles, author: author, readingCount: readingCount, fileSize: fileSize, description: descriptions, money: money)
        
        coverView.shoppingCar.addTarget(self, action: #selector(didClickFirstReadingButton(_:)), forControlEvents: .TouchUpInside)
        
        coverView.btnMoney.addTarget(self, action: #selector(didClickFirstReadingButtons(_:)), forControlEvents: .TouchUpInside)
        
        coverView.books.addTarget(self, action: #selector(didClickAddBookStoreButtons(_:)), forControlEvents: .TouchUpInside)
        
        view = coverView
        progress.progressTintColor = UIColor.colorWithString("#f62e1e")
        view.addSubview(progress)
        progress.progress = 0.0
        progress.snp_makeConstraints { (make) in
            make.width.equalTo(coverView).multipliedBy(0.8)
            make.height.equalTo(SCREEN_SCALE_HEIGHT * 15)
            make.bottom.equalTo(coverView.btnMoney.snp_top)
            make.centerX.equalTo(view)
        }
        self.coverViews = coverView

//        progressV = ZJProgress(frame: CGRectMake(100, 300, 200, 200))
//        view.addSubview(progressV!)
//        view.bringSubviewToFront(progressV!)
        
        dataPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first
        
    }
    
    deinit {
        self.coverViews = nil
        print("\(self.debugDescription) --- 销毁")
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBarHidden = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(isPayOK), name: kThirdNotification, object: nil)
    }
    
    @objc private func isPayOK() {
        self.navigationController?.popToRootViewControllerAnimated(true)
        CHProgressHUD.showInfoWithStatus("您购买的图书已加入书架")
    }
    
    /**
     点击加入书架按钮
     */
    func didClickAddBookStoreButtons(sender: UIButton) {
        
        print("加入书架")

        let userid = "16"
//        let userid = String(NSUserDefaults.standardUserDefaults().objectForKey("userID")!)

        DDAddBookStoreModel.loadAddBookStoreData(userid, bookid: bookid) { (result) in
            
            guard let result = result else {
                
                let alertview = UIAlertView(title: "标题", message: "请先购买图书", delegate: self, cancelButtonTitle: "确定")
                alertview.show()
                return
            }
            
            let alertview = UIAlertView(title: "标题", message: "您购买的图书已经加入书架", delegate: self, cancelButtonTitle: "确定")
            alertview.show()
            print("result: \(result)")
        }
    }
    
    @objc private func didClickFirstReadingButtons(button: UIButton) {
        
        if ZJAccountModel.isLogin() {
            
//            let thirdPayViewController = CHThirdPayController()
//                    thirdPayViewController.bookId = bookid
//            self.navigationController?.pushViewController(thirdPayViewController, animated: true)
            
            let alertVC = UIAlertController(title: nil, message: "请选择支付方式", preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "微信", style: .Default, handler: { (action) in
                
//                let parameters: [String : AnyObject] = ["user_id": "16",
//                    "book_id": "13"]
//
//                CHNetworkTools.sharedNetworkTool.post(URL_CREATEORDRE, parameters: parameters) { (success, result, error) in
//                    
//                    print("支付商户服务器返回结果： \(result ?? "")")
//                    
//                    guard let result = result where result["status"] == "success" else {
//                        return
//                    }
//                    
//                    let data = result["list"].arrayObject as! [[String : AnyObject]]
//                    for dict in data {
//                        
////                        let payParams = dict["result"] as! String
////                        WeChat.weChatPay(dict)
//                        
//                        print("微信支付")
//                    }
//                }
            })

            let alertAction1 = UIAlertAction(title: "支付宝", style: UIAlertActionStyle.Default, handler: { (action) in
                
                let parameters: [String : AnyObject] = ["user_id": "16",
                                                        "book_id": "13"]
                
                CHNetworkTools.sharedNetworkTool.post(URL_CREATEORDRE, parameters: parameters) { (success, result, error) in
                    
                    print("支付商户服务器返回结果： \(result ?? "")")
                    
                    guard let result = result where result["status"] == "success" else {
                        return
                    }
                    
                    let data = result["list"].arrayObject as! [[String : AnyObject]]
                    for dict in data {
                        
                        let payParams = dict["result"] as! String
                        CHAliPay.aliPay(payParams)
                    }
                }
            })
            
            alertVC.addAction(alertAction1)
            alertVC.addAction(alertAction)
            self.presentViewController(alertVC, animated: true, completion: nil)
        }else {
            
            let alertVC = UIAlertController(title: nil, message: "请登录", preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "确认", style: .Default, handler: { (action) in
                let loginVc = ZJLoginViewController()
                self.navigationController?.pushViewController(loginVc, animated: true)
            })
            let alertAction1 = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            alertVC.addAction(alertAction)
            alertVC.addAction(alertAction1)
            self.presentViewController(alertVC, animated: true, completion: nil)
        }
    }
    
    /** 点击试读按钮时 */
    func didClickFirstReadingButton(sender: UIButton) {
        
        /** 这里进行数据的下载 */
        downLoadFile(readingURL)
//        setDownLoadFile()
    }
    
    func setDownLoadFile() {
        let urlPath = NSURL(string: "\(BASE_URL ?? "")\(readingURL ?? "")")
        let str = urlPath?.lastPathComponent
        if str == "" {
            CHProgressHUD.showInfoWithStatus("图书有问题，不能阅读")
            return
        }
        let indexStr = str?.endIndex.advancedBy(-5)
        let urlStr2 = str?.substringToIndex(indexStr!)

//        // 1、获得沙盒的根路径
//        let home = NSHomeDirectory() as NSString
//        
//        // 2、获得Documents路径，使用NSString对象的stringByAppendingPathComponent()方法拼接路径
//        let docPath = home.stringByAppendingPathComponent("Documents") as NSString
//        
//        // 3、获取文本文件路径
//        let filePath = docPath.stringByAppendingPathComponent("\(urlStr2 ?? "").epub");
//        
//        let url = NSURL(string: filePath)
       
        /** 文件内存大小, 以字符串的方式返回 */
        let files = NSFileManager.defaultManager().subpathsAtPath(dataPath!)
        
        /** 取出所有文件名 */
        for fileName in files! {
            
            print("filename: \(fileName)")
            print("urlStr2: \(urlStr2)")
            
            if fileName != "\(urlStr2 ?? "").epub" {
                continue
            }
            
            if fileName == "\(urlStr2 ?? "").epub" {
                
                /** 把文件名拼接到路径中 */
                let path = dataPath!.stringByAppendingFormat("/\(fileName)")
                let url = NSURL(string: path)
                
                
                CHProgressHUD.showWithStatus("正在加载数据")
                let pageView = LSYReadPageViewController()
                pageView.resourceURL = url
                dispatch_async(dispatch_get_global_queue(0, 0)) {
                    pageView.model = LSYReadModel.getLocalModelWithURL(url) as? LSYReadModel
                    dispatch_async(dispatch_get_main_queue(), {
                        CHProgressHUD.dismiss()
                        self.presentViewController(pageView, animated: true, completion: nil)
                    })
                }
            }
            // 582977f51e08a
            // 5800c2b1e9978
        }
        
        
        
//        let url = NSURL(string: filePath)
        
//        if indexStr != nil {
//            CHProgressHUD.showWithStatus("正在加载数据")
//            let pageView = LSYReadPageViewController()
//            pageView.resourceURL = url
//            dispatch_async(dispatch_get_global_queue(0, 0)) {
//                pageView.model = LSYReadModel.getLocalModelWithURL(url) as? LSYReadModel
//                dispatch_async(dispatch_get_main_queue(), {
//                    CHProgressHUD.dismiss()
//                    self.presentViewController(pageView, animated: true, completion: nil)
//                })
//            }
//            
////            let pageView = LSYReadPageViewController()
////            pageView.resourceURL = url
////            pageView.model = LSYReadModel.getLocalModelWithURL(url) as? LSYReadModel
////            self.presentViewController(pageView, animated: true, completion: nil)
//            
//        }else {
//            let alertVc = UIAlertController(title: nil, message: "您下载的图书有问题！", preferredStyle: .ActionSheet)
//            let alertActionCancel = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
//            let alertActionDone = UIAlertAction(title: "确定", style: .Default, handler: { (UIAlertAction) in
//                self.navigationController?.popToRootViewControllerAnimated(true)
//            })
//            alertVc.addAction(alertActionCancel)
//            alertVc.addAction(alertActionDone)
//            self.navigationController?.presentViewController(alertVc, animated: true, completion: nil)
//        }
        
    }
    
    /// 文件下载，获取文件下载进度
    func downLoadFile(fileURL: String) {
//        let urlPath = NSURL(string: "\(BASE_URL ?? "")\(readingURL ?? "")")
//        let str = urlPath?.lastPathComponent
//        if str == "" {
//            CHProgressHUD.showInfoWithStatus("图书有问题，不能阅读")
//            return
//        }
//        let indexStr = str?.endIndex.advancedBy(-5)
//        let urlStr2 = str?.substringToIndex(indexStr!)
//        /** 文件内存大小, 以字符串的方式返回 */
//        let files = NSFileManager.defaultManager().subpathsAtPath(dataPath!)
//        
//        /** 取出所有文件名 */
//        for fileName in files! {
//            
//            print("filename: \(fileName)")
//            print("urlStr2: \(urlStr2)")
//            
//            if urlStr2 == nil || fileName != "\(urlStr2 ?? "").epub" {
        
                //下载文件的保存路径
                let destination = Alamofire.Request.suggestedDownloadDestination(
                    directory: .DocumentDirectory, domain: .UserDomainMask)
                var downloadRequest: Request!
                // 页面加载完毕就自动开始下载
                downloadRequest = Alamofire.download(.GET, "\(BASE_URL ?? "")\(fileURL ?? "")", destination: destination)
                // 下载进度
                downloadRequest.progress(downloadProgress)
                // 下载停止
                downloadRequest.response(completionHandler: downloadResponse)
                
//            }else {
//                
//                if fileName != "\(urlStr2 ?? "").epub" {
//                    continue
//                }
//                
//                if fileName == "\(urlStr2 ?? "").epub" {
//                    
//                    /** 把文件名拼接到路径中 */
//                    let path = dataPath!.stringByAppendingFormat("/\(fileName)")
//                    let url = NSURL(string: path)
//                    
//                    
//                    CHProgressHUD.showWithStatus("正在加载数据")
//                    let pageView = LSYReadPageViewController()
//                    pageView.resourceURL = url
//                    dispatch_async(dispatch_get_global_queue(0, 0)) {
//                        pageView.model = LSYReadModel.getLocalModelWithURL(url) as? LSYReadModel
//                        dispatch_async(dispatch_get_main_queue(), {
//                            CHProgressHUD.dismiss()
//                            self.presentViewController(pageView, animated: true, completion: nil)
//                        })
//                    }
//                }
//            }
            // 582977f51e08a
            // 5800c2b1e9978
//        }
    }
    
    // 下载过程中改变进度条
    func downloadProgress(bytesRead: Int64, totalBytesRead: Int64, totalBytesExpectedToRead: Int64) {
        let percent = Float(totalBytesRead)/Float(totalBytesExpectedToRead)
        // 进度条更新
        dispatch_async(dispatch_get_main_queue()) {
            self.progress.setProgress(percent, animated: true)
        }
        print("当前进度: \(percent*100)%")
        
        if percent == 1.0 {
            
            print("完成进度: \(percent)")
//            dispatch_async(dispatch_get_main_queue()) {
                self.setDownLoadFile()
//            }
        }
    }
    
    //下载停止响应（不管成功或者失败）
    func downloadResponse(request: NSURLRequest?, response: NSHTTPURLResponse?,
                          data: NSData?, error:NSError?) {
        if let error = error {
            if error.code == NSURLErrorCancelled {
                //意外终止的话，进行其他操作
                dispatch_async(dispatch_get_main_queue()) {
                    
                    let alertVc = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
                    let alertActionCancel = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
                    let alertActionDone = UIAlertAction(title: "确定", style: .Default, handler: { (UIAlertAction) in
                        
                        self.navigationController?.popToRootViewControllerAnimated(true)
                        
                    })
                    alertVc.addAction(alertActionCancel)
                    alertVc.addAction(alertActionDone)
                    self.navigationController?.presentViewController(alertVc, animated: true, completion: nil)
                }
            } else {
                print("Failed to download file: \(response) \(error)")
            }
        } else {
            print("Successfully downloaded file: \(response)")
        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
