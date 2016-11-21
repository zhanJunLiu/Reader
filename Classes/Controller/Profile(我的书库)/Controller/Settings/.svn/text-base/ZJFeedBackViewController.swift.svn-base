//
//  ZJFeedBackViewController.swift
//  Book
//
//  Created by mac on 16/9/14.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class ZJFeedBackViewController: ZJMainVc {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "用户反馈"
        
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupUI() {
        
        view.addSubview(txtContent)
        view.addSubview(btnCommit)
        txtContent.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(SCREEN_SCALE_HEIGHT * 600)
        }
        
        btnCommit.snp_makeConstraints { (make) in
            make.top.equalTo(txtContent).offset(SCREEN_SCALE_HEIGHT * 640)
            make.left.equalTo(self.view).offset(SCREEN_SCALE_WIDTH * 20)
            make.right.equalTo(self.view).offset(SCREEN_SCALE_WIDTH * -20)
            make.height.equalTo(SCREEN_SCALE_HEIGHT * 80)
        }
    }
    
    private lazy var txtContent: UITextView = {
        let txt = UITextView()
        return txt
    }()
    
    private lazy var btnCommit: UIButton = {
        let commit = UIButton()
        commit.layer.cornerRadius = 5
        commit.setTitle("提交", forState: .Normal)
        commit.titleLabel?.font = UIFont.systemFontOfSize(18)
        commit.tintColor = UIColor.whiteColor()
        commit.setBackgroundImage(UIImage(named: "goumai"), forState: .Normal)
        return commit
    }()
}
