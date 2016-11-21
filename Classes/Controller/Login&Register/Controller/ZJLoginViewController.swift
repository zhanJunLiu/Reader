//
//  ZJLoginViewController.swift
//  Scholar
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class ZJLoginViewController: ZJMainVc, ZJRegisterViewControllerDelegate {

    let loginView = ZJLoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        /** 隐藏导航栏 */
        self.navigationController?.navigationBarHidden = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didClickWeChatOK), name: kWeChatLoginNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didClickWeChatOK), name: kWeChatLoginOk, object: nil)
    }
    
    private func setupUI() { /** 设置登录界面 */

        self.view.addSubview(loginView)
        loginView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        
        /** 为手机号码设置正则表达式 */
        loginView.iPhone.addTarget(self, action: #selector(textFieldChangeText), forControlEvents: .EditingChanged)
        
        /** 登录界面的按钮点击事件 */
        loginView.btnRegister.addTarget(self, action: #selector(didClickRegisterButton(_:)), forControlEvents: .TouchUpInside)
        
        loginView.btnLogin.addTarget(self, action: #selector(didClickLoginButton(_:)), forControlEvents: .TouchUpInside)
        
        loginView.btnVisitor.addTarget(self, action: #selector(didClickVisitorButton), forControlEvents: .TouchUpInside)
        
        loginView.QQLogin.addTarget(self, action: #selector(didClickQQLoginButton(_:)), forControlEvents: .TouchUpInside)
        
        loginView.SinaLogin.addTarget(self, action: #selector(didClickSinaLoginButton(_:)), forControlEvents: .TouchUpInside)
        
        loginView.btnCancel.addTarget(self, action: #selector(didCancelButton), forControlEvents: .TouchUpInside)
        
        loginView.weixinLogin.addTarget(self, action: #selector(didClickweixinLoginButton(_:)), forControlEvents: .TouchUpInside)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    /**
     键盘即将显示
     */
    @objc private func keyboardWillShow(notification: NSNotification) {
        
        let userInfo = notification.userInfo!
        
        let beginHeight = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue().size.height
        let endHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size.height
        
        if beginHeight > 0 && endHeight > 0 {
            UIView.animateWithDuration(0.25) {
                self.view.transform = CGAffineTransformMakeTranslation(0, -endHeight + (SCREEN_H - CGRectGetMaxY(self.loginView.btnLogin.frame)) - 10)
            }
        }
    }
    
    /**
     键盘即将隐藏
     */
    @objc private func keyboardWillHide(notification: NSNotification) {
        UIView.animateWithDuration(0.25) {
            self.view.transform = CGAffineTransformIdentity
        }
    }
}

extension ZJLoginViewController {
    
    /** 注册按钮 */
    @objc private func didClickRegisterButton(button: UIButton) {
        let vc = ZJRegisterViewController()
        vc.delegate = self
        vc.passwordOrRegister = 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /** 登录按钮 */
    @objc private func didClickLoginButton(button: UIButton) {
        CHProgressHUD.showWithStatus("正在登录")
        ZJAccountModel.normalAccountLogin("tel", username: "\(loginView.iPhone.text ?? "")", password: "\(loginView.password.text ?? "")") { (success, tip) in
            if success {
                CHProgressHUD.dismiss()
                NSUserDefaults.standardUserDefaults().setObject(self.loginView.iPhone.text!, forKey: "user_id")
                NSUserDefaults.standardUserDefaults().setObject(self.loginView.password.text!, forKey: "password")
                self.dismissViewControllerAnimated(true, completion: nil)
                NSUserDefaults.standardUserDefaults().setObject(userID, forKey: "userID")

                self.navigationController?.popToRootViewControllerAnimated(true)
                
            }else {
                CHProgressHUD.showInfoWithStatus(tip)
            }
        }
    }

    /** 找回密码 */
    func didClickVisitorButton() {
        
        let vc = ZJRegisterViewController()
        vc.delegate = self
        vc.passwordOrRegister = 1
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    /** 取消按钮 */
    func didCancelButton() {
//        self.navigationController?.popToRootViewControllerAnimated(true)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    /** QQ快速按钮 */
    @objc private func didClickQQLoginButton(button: UIButton) {
        
        ShareSDK.getUserInfo(SSDKPlatformType.TypeQQ) { (state, user, error) in
            
            if state == SSDKResponseState.Success {
                print("登录成功")
                self.SDKLoginHandle(state, user: user, type: "QQ")
            }else {
                print("登录失败")
                 CHProgressHUD.showInfoWithStatus("\(error)")
            }
        }
    }

    /** 微博快速按钮 */
    @objc private func didClickSinaLoginButton(button: UIButton) {
        
        ShareSDK.getUserInfo(SSDKPlatformType.TypeSinaWeibo) { (state, user, error) in
            
            if state == SSDKResponseState.Success {
                
                self.SDKLoginHandle(state, user: user, type: "weibo")
            }else {
                
                CHProgressHUD.showInfoWithStatus("\(error)")
            }
        }
    }
    
    /** 微信快速按钮 */
    @objc private func didClickweixinLoginButton(button: UIButton) {
        
        print("微信登录按钮 -> ")
        
        WeChat.weChatLogin()    
    }
    
    @objc private func didClickWeChatOK() {
        print("微信普通回调成功")
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    //MARK:点击事件
    //输入账号密码
    @objc
    private func textFieldChangeText(){
        
        if loginView.iPhone.text!.isTelNumber(){
            
            loginView.btnLogin.enabled = true
        }else {
            loginView.btnLogin.enabled = false
        }
    }
    
    /** ZJRegisterViewControllerDelegate */
    func registerSuccess(user_id: String, password: String) {
        
        loginView.iPhone.text = user_id
        loginView.password.text = password
        textFieldChangeText()
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            self.didClickLoginButton(self.loginView.btnLogin)
        }
    }
    
    /**
     第三方登录处理
     
     - parameter state: 授权状态
     - parameter user:  授权用户信息
     - parameter error: 错误对象
     - parameter type:  0:qq 1:weibo
     */
    func SDKLoginHandle(state: SSDKResponseState, user: SSDKUser, type: String) {
        
        let uid = user.uid
        let token = user.credential.token
        let nickname = user.nickname
        let avatar = type == "weibo" ? (user.rawData["avatar_hd"] != nil ? user.rawData["avatar_hd"]! as! String : user.icon) : (user.rawData["figureurl_qq_2"] != nil ? user.rawData["figureurl_qq_2"]! as! String : user.icon)
        let sex = user.gender.rawValue == 0 ? 1 : 0
        
        CHProgressHUD.showWithStatus("正在登录")
        ZJAccountModel.thirdAccountLogin(type, openid: uid, token: token, nickname: nickname, avatar: avatar, sex: sex, finished: { (success, tip) in
            if success {
                CHProgressHUD.dismiss()
                NSUserDefaults.standardUserDefaults().setObject(self.loginView.iPhone.text!, forKey: "")
                NSUserDefaults.standardUserDefaults().setObject(self.loginView.password.text!, forKey: "")
                self.didClickVisitorButton()
                self.navigationController?.popToRootViewControllerAnimated(true)
                
            } else {
                CHProgressHUD.showInfoWithStatus(tip)
            }
        })
    }
}
