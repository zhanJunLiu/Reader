//
//  DDActivityDetailsViewController.swift
//  CHReadingBook
//
//  Created by zhuzi on 16/10/12.
//  Copyright © 2016年 mac. All rights reserved.
//

let web = "\(BASE_URL)/index.php/html/active/id/"


import UIKit

class DDActivityDetailsViewController: UIViewController {
    
    var webView = UIWebView()
    
    var activityID: String?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H)
        let webString = "\(web)" + activityID!
        let request = NSURLRequest(URL: NSURL(string: webString)!)
        view.addSubview(webView)
        webView.loadRequest(request)
        
        createButton()
        
    }
    
    func createButton() {
        let backButton = UIButton(type: UIButtonType.Custom)
        backButton.frame = CGRectMake(0, 0, 60, 50)
        backButton.addTarget(self, action: #selector(DDActivityDetailsViewController.buttonClick), forControlEvents: UIControlEvents.TouchUpInside)
        webView.addSubview(backButton)
    }

    func buttonClick() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
  
}
