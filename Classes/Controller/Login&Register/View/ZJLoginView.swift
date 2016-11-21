
//
//  ZJLoginView.swift
//  Scholar
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

/** 登录界面字号 */
private let fontSize: CGFloat = 20

/** 找回密码 */
private let pswfontSize: CGFloat = 15

/** 第三方登录按钮大小 */
private let BtnSize: CGFloat = 120

/** 第三方登录按钮间距 */
private let btnMargin: CGFloat = 40

class ZJLoginView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.layer.contents  = UIImage(named: "bgLogin")?.CGImage
        
        setTextField(iPhone, placeholder: "手机号", type: .PhonePad, leftImage: "yonghuming")
        setTextField(password, placeholder: "密码", type: .PhonePad, leftImage: "mima")
        
        addSubview(imageV)
        addSubview(iPhoneBg)
        iPhoneBg.addSubview(iPhone)
        iPhoneBg.addSubview(iPhoneIcon)
        addSubview(passwordBg)
        passwordBg.addSubview(password)
        passwordBg.addSubview(passwordIcon)
        addSubview(btnRegister)
        addSubview(btnVisitor)
        addSubview(btnLogin)
        addSubview(lblThreeLoginTitle)
        addSubview(QQLogin)
        addSubview(SinaLogin)
        addSubview(weixinLogin)
        addSubview(reightV)
        addSubview(leftV)
        addSubview(btnCancel)
        
        weak var weakSelf = self
        
        imageV.snp_makeConstraints { (make) in
            make.centerX.equalTo(weakSelf!)
            make.top.equalTo(weakSelf!).offset(SCREEN_SCALE_HEIGHT * 160)
            make.size.equalTo(CGSizeMake(SCREEN_SCALE_WIDTH * 250, SCREEN_SCALE_HEIGHT * 270))
        }
        iPhone.snp_makeConstraints { (make) in
            make.centerY.equalTo(iPhoneBg)
            make.height.equalTo(iPhoneBg)
            make.left.equalTo(iPhoneBg).offset(SCREEN_SCALE_WIDTH * 50)
            make.right.equalTo(iPhoneBg)
        }
        iPhoneBg.snp_makeConstraints { (make) in
            make.top.equalTo(imageV.snp_bottom).offset(SCREEN_SCALE_HEIGHT * 80)
            make.left.equalTo(weakSelf!).offset(SCREEN_SCALE_WIDTH * 50)
            make.right.equalTo(weakSelf!).offset(SCREEN_SCALE_WIDTH * -50)
            make.height.equalTo(SCREEN_SCALE_HEIGHT * 100)
        }
        iPhoneIcon.snp_makeConstraints { (make) in
            make.height.equalTo(iPhoneBg).multipliedBy(0.6)
            make.centerY.equalTo(iPhoneBg)
            make.left.equalTo(iPhoneBg).offset(SCREEN_SCALE_WIDTH * 20)
            make.right.equalTo(iPhone.snp_left).offset(SCREEN_SCALE_WIDTH * 30)
        }
        password.snp_makeConstraints { (make) in
            make.centerY.equalTo(passwordBg)
            make.height.equalTo(passwordBg)
            make.left.equalTo(passwordBg).offset(SCREEN_SCALE_WIDTH * 50)
            make.right.equalTo(passwordBg)
        }
        passwordBg.snp_makeConstraints { (make) in
            make.top.equalTo(iPhoneBg.snp_bottom).offset(SCREEN_SCALE_HEIGHT * 40)
            make.size.equalTo(iPhoneBg)
            make.left.equalTo(iPhoneBg)
        }
        passwordIcon.snp_makeConstraints { (make) in
            make.height.equalTo(passwordBg).multipliedBy(0.6)
            make.centerY.equalTo(passwordBg)
            make.left.equalTo(passwordBg).offset(SCREEN_SCALE_WIDTH * 25)
            make.right.equalTo(password.snp_left).offset(SCREEN_SCALE_WIDTH * 10)
        }
        btnRegister.snp_makeConstraints { (make) in
            make.height.equalTo(passwordBg)
            make.left.equalTo(passwordBg)
            make.top.equalTo(passwordBg.snp_bottom).offset(SCREEN_SCALE_HEIGHT * 40)
            make.right.equalTo(passwordBg.snp_centerX).offset(SCREEN_SCALE_WIDTH * -10)
        }
        btnLogin.snp_makeConstraints { (make) in
            make.size.equalTo(btnRegister)
            make.centerY.equalTo(btnRegister)
            make.right.equalTo(passwordBg)
        }
        btnVisitor.snp_makeConstraints { (make) in
            make.centerX.equalTo(imageV)
            make.top.equalTo(btnRegister.snp_bottom).offset(SCREEN_SCALE_HEIGHT * 20)
            make.size.equalTo(btnLogin)
        }
        lblThreeLoginTitle.snp_makeConstraints { (make) in
            make.bottom.equalTo(weakSelf!).offset(SCREEN_SCALE_HEIGHT * -150)
            make.centerX.equalTo(weakSelf!)
        }
        SinaLogin.snp_makeConstraints { (make) in
            make.centerX.equalTo(lblThreeLoginTitle)
            make.top.equalTo(lblThreeLoginTitle.snp_bottom).offset(SCREEN_SCALE_HEIGHT * 10)
            make.size.equalTo(CGSizeMake(SCREEN_SCALE_WIDTH * BtnSize, SCREEN_SCALE_HEIGHT * BtnSize))
        }
        QQLogin.snp_makeConstraints { (make) in
            make.centerY.equalTo(SinaLogin)
            make.size.equalTo(SinaLogin)
            make.right.equalTo(lblThreeLoginTitle.snp_left)
        }
        weixinLogin.snp_makeConstraints { (make) in
            make.centerY.equalTo(SinaLogin)
            make.size.equalTo(SinaLogin)
            make.left.equalTo(lblThreeLoginTitle.snp_right)
        }
        reightV.snp_makeConstraints { (make) in
            make.width.equalTo(SCREEN_SCALE_WIDTH * 90)
            make.height.equalTo(2)
            make.centerY.equalTo(lblThreeLoginTitle)
            make.left.equalTo(lblThreeLoginTitle.snp_right).offset(SCREEN_SCALE_WIDTH * 20)
        }
        leftV.snp_makeConstraints { (make) in
            make.size.equalTo(reightV)
            make.centerY.equalTo(lblThreeLoginTitle)
            make.right.equalTo(lblThreeLoginTitle.snp_left).offset(SCREEN_SCALE_WIDTH * -20)
        }
        
        btnCancel.snp_makeConstraints { (make) in
            make.right.equalTo(weakSelf!).offset(SCREEN_SCALE_WIDTH * -30)
            make.top.equalTo(weakSelf!).offset(SCREEN_SCALE_HEIGHT * 40)
            make.size.equalTo(CGSize(width: SCREEN_SCALE_WIDTH * 100, height: SCREEN_SCALE_HEIGHT * 50))
        }
        
    }
    
    func setTextField(textfield: UITextField, placeholder: String?, type:UIKeyboardType, leftImage: String?) -> UITextField {
        
        textfield.layer.cornerRadius = 5
        textfield.backgroundColor = UIColor.clearColor()
        textfield.textColor = UIColor.whiteColor()
        textfield.font = UIFont.systemFontOfSize(14)
        textfield.placeholder = placeholder;
        textfield.keyboardType = type
        return textfield
    }
    
    /** log图片 */
    private lazy var imageV: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(named: "登录页图标")
        return imageV
    }()
    
    /** 手机号码 */
    lazy var iPhone: UITextField = {
        let iPhone = MTTextField()
        return iPhone
    }()
    
    /** 存放手机号的背景 */
    private lazy var iPhoneBg: UIImageView = {
        let iPhoneBg = UIImageView()
        iPhoneBg.userInteractionEnabled = true
        iPhoneBg.image = UIImage(named: "Login_10")
        return iPhoneBg
    }()
    
    /** 手机号icon */
    private lazy var iPhoneIcon: UIImageView = {
        let iPhoneIcon = UIImageView()
        iPhoneIcon.image = UIImage(named: "yonghuming")
        return iPhoneIcon
    }()
    
    /** 密码 */
    lazy var password: UITextField = {
        let password = MTTextField()
        password.secureTextEntry = true
        return password
    }()
    
    /** 存放密码的背景 */
    private lazy var passwordBg: UIImageView = {
        let passwordBg = UIImageView()
        passwordBg.userInteractionEnabled = true
        passwordBg.image = UIImage(named: "Login_10")
        return passwordBg
    }()
    
    /** 密码钥匙icon */
    private lazy var passwordIcon: UIImageView = {
        let passwordIcon = UIImageView()
        passwordIcon.image = UIImage(named: "mima")
        return passwordIcon
    }()
    
    /** 注册按钮 */
    lazy var btnRegister: UIButton = {
        let btnRegister = UIButton()
        btnRegister.setTitle("注册", forState: .Normal)
        btnRegister.setBackgroundImage(UIImage(named: "Login_13"), forState: .Normal)
        btnRegister.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        btnRegister.tintColor = ZJGlobalWitheColor()
        return btnRegister
    }()
    
    /** 登录按钮 */
    lazy var btnLogin: UIButton = {
        let btnLogin = UIButton()
        btnLogin.setTitle("登录", forState: .Normal)
        btnLogin.setBackgroundImage(UIImage(named: "Login_15"), forState: .Normal)
        btnLogin.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        btnLogin.tintColor = ZJGlobalWitheColor()
        return btnLogin
    }()
    
    /** 游客登录 */
    lazy var btnVisitor: UIButton = {
        let btnVisitor = UIButton()
        btnVisitor.setTitle("找回密码", forState: .Normal)
        btnVisitor.titleLabel?.font = UIFont.systemFontOfSize(pswfontSize)
        btnVisitor.tintColor = ZJGlobalBlackBlueColor()
        return btnVisitor
    }()
    
    /** 第三方登录标题 */
    private lazy var lblThreeLoginTitle: UILabel = {
        let lblThreeLoginTitle = UILabel()
        lblThreeLoginTitle.text = "合作账号登录"
        lblThreeLoginTitle.textColor = ZJGlobalBlackBlueColor()
        return lblThreeLoginTitle
    }()
    
    /** QQ登录按钮 */
    lazy var QQLogin: UIButton = {
        let QQLogin = UIButton()
        QQLogin.setImage(UIImage(named: "qq_295_1968"), forState: .Normal)
        return QQLogin
    }()
    
    /** 微博登录按钮 */
    lazy var SinaLogin: UIButton = {
        let SinaLogin = UIButton()
        SinaLogin.setImage(UIImage(named: "weibo_539_1968"), forState: .Normal)
        return SinaLogin
    }()
    
    /** 微信登录按钮 */
    lazy var weixinLogin: UIButton = {
        let weixinLogin = UIButton()
        weixinLogin.setImage(UIImage(named: "weixin_783_1968"), forState: .Normal)
        return weixinLogin
    }()
    
    /** 取消按钮 */
    lazy var btnCancel:   UIButton = {
        let cancel = UIButton()
        cancel.setTitle("取消", forState: .Normal)
        cancel.setTitleColor(ZJGlobalBlackBlueColor(), forState: .Normal)
        return cancel
    }()
    
    /** 分割线 */
    private lazy var reightV: UIView = {
        let reightV = UIView()
        reightV.backgroundColor = ZJGlobalBlackBlueColor()
        return reightV
    }()
    
    /** 分割线 */
    private lazy var leftV: UIView = {
        let leftV = UIView()
        leftV.backgroundColor = ZJGlobalBlackBlueColor()
        return leftV
    }()
}
