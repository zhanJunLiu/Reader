//
//  ZJConnectNetViewController.swift
//  Book
//
//  Created by mac on 16/9/14.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class ZJConnectNetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = UIWebView()
        webView.frame = view.bounds
        /// 自动对页面进行缩放以适应屏幕
        webView.scalesPageToFit = true
        webView.dataDetectorTypes = .All
        let url = NSURL(string: "http://www.baidu.com")
        print("网址: \(url)")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        view.addSubview(webView)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
