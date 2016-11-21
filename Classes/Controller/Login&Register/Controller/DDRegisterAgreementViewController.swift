//
//  DDRegisterAgreementViewController.swift
//  CHReadingBook
//
//  Created by zhuzi on 2016/11/11.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

//protocol ZJRegisterViewControllerDelegate: NSObjectProtocol {
//    
//    func registerSuccess(user_id: String, password: String)
//}

class DDRegisterAgreementViewController: UIViewController {
    
    var scrollView = UIScrollView()
    var agreementLabel = UILabel()
    var agreementBtn = UIButton()

    
//    weak var delegate: ZJRegisterViewControllerDelegate?
    
    //接受上一个界面传来的数据
    var verifty: String!
    var password: String!
    var register: ZJRegisterView?
    var delegateR: ZJRegisterViewControllerDelegate?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "用户注册协议"
        createUI()
    }

    
    func createUI() {
        
        
        //创建scrollerView
        self.scrollView = UIScrollView(frame: view.bounds)
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.bounces = false
        self.view.addSubview(self.scrollView)
        
//        self.scrollView.contentSize = CGSizeMake(2 * SCREEN_W, 0)
        
        
        //创建协议内容label
        agreementLabel = UILabel(frame: CGRectMake(5, 66, SCREEN_W - 10, SCREEN_H - 200))
        agreementLabel.text = ""
        scrollView.addSubview(agreementLabel)
        
        
        //创建接受协议button
        agreementBtn = UIButton(type: UIButtonType.Custom)
        agreementBtn.frame = CGRectMake(SCREEN_SCALE_WIDTH*180, agreementLabel.y + agreementLabel.height, SCREEN_W - SCREEN_SCALE_WIDTH*360, SCREEN_SCALE_HEIGHT*90)
        agreementBtn.setImage(UIImage(named: "jieshou_346_6362"), forState: UIControlState.Normal)
        agreementBtn.addTarget(self, action: #selector(agreementBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        scrollView.addSubview(agreementBtn)
        
    }
    
    @objc private func agreementBtnClick() {
        
        print("提交 -> ")
//        print("Phone: \(registerView.txtIPhone.text)")
//        print("verifty: \(registerView.txtInputVerifty.text)")
//        print("password: \(registerView.txtInputPassword.text)")
        
        if verifty == "" && password == "" {
            CHProgressHUD.showErrorWithStatus("手机号不能为空或者密码不能为空")
            return
        }
//        SMSSDK.commitVerificationCode(register!.txtInputVerifty.text, phoneNumber: register!.txtIPhone.text, zone: "86") { (error) in
//            if error == nil {
//                print("验证成功")
//                CHProgressHUD.showWithStatus("正在提交")
//                ZJAccountModel.normalAccountRegister("tel", username: self.register!.txtIPhone.text!, password: self.register!.txtInputPassword.text!, finished: { (success, tip) in
//                    if success {
//                        CHProgressHUD.dismiss()
//                        self.delegateR?.registerSuccess(self.register!.txtIPhone.text!, password: self.register!.txtInputPassword.text!)
//                    }else {
//                        CHProgressHUD.showInfoWithStatus(tip)
//                    }
//                })
//            }else {
//                print("错误信息: \(error)")
//            }
//        }
    }
}
