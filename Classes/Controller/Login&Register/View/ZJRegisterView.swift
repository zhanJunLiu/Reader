//
//  ZJRegisterView.swift
//  Scholar
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

/** 提示宽度 */
private let alertSize: CGFloat = 130

/** 间距 */
private let margin:    CGFloat = 20

class ZJRegisterView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        
        setLabel(lblVerify, lblText: "验证码", color: ZJGlobalBlackBlueColor(), alignment: .Center, fontSize: 17)
        setLabel(lblInputAlert, lblText: "基本信息填写:", color: ZJGlobalBlackBlueColor(), alignment: .Left, fontSize: 20)
        setLabel(lblPassword, lblText: "密  码", color: ZJGlobalBlackBlueColor(), alignment: .Center, fontSize: 17)
        
        addSubview(navView)
        navView.addSubview(title)
        navView.addSubview(btnBack)
        addSubview(lblInputAlert)
        addSubview(imgIPhoneBg)
        imgIPhoneBg.addSubview(lblIPhoneID)
        imgIPhoneBg.addSubview(txtIPhone)
        addSubview(imgVerifyBg)
        imgVerifyBg.addSubview(lblVerify)
        imgVerifyBg.addSubview(txtInputVerifty)
        addSubview(btnSendVerify)
        addSubview(imgPasswordBg)
        imgPasswordBg.addSubview(lblPassword)
        imgPasswordBg.addSubview(txtInputPassword)
        addSubview(btnSubmit)
        
        navView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(64)
        }
        
        btnBack.snp_makeConstraints { (make) in
            make.bottom.equalTo(navView).offset(SCREEN_SCALE_HEIGHT * -margin)
            make.left.equalTo(navView).offset(SCREEN_SCALE_WIDTH * (margin * 2))
            make.size.equalTo(CGSizeMake(SCREEN_SCALE_WIDTH * (margin * 2), SCREEN_SCALE_HEIGHT * (margin * 2)))
        }
        
        title.snp_makeConstraints { (make) in
            make.centerY.equalTo(btnBack)
            make.centerX.equalTo(navView)
        }
        
        lblInputAlert.snp_makeConstraints { (make) in
            make.top.equalTo(navView.snp_bottom).offset(SCREEN_SCALE_HEIGHT * (margin * 2))
            make.left.equalTo(self).offset(SCREEN_SCALE_WIDTH * (margin * 2))
        }
        
        imgIPhoneBg.snp_makeConstraints { (make) in
            make.left.equalTo(lblInputAlert)
            make.top.equalTo(lblInputAlert.snp_bottom).offset(SCREEN_SCALE_HEIGHT * (margin * 2))
            make.right.equalTo(self).offset(SCREEN_SCALE_WIDTH * -(margin * 2))
            make.height.equalTo(SCREEN_SCALE_HEIGHT * (margin * 5))
        }
        
        txtIPhone.snp_makeConstraints { (make) in
            make.height.equalToSuperview()
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview().offset(SCREEN_SCALE_WIDTH * alertSize)
        }
        
        lblIPhoneID.snp_makeConstraints { (make) in
            make.height.equalTo(imgIPhoneBg)
            make.centerY.equalTo(imgIPhoneBg)
            make.left.equalTo(imgIPhoneBg)
            make.right.equalTo(txtIPhone.snp_left)
        }
        
        imgVerifyBg.snp_makeConstraints { (make) in
            make.height.equalTo(imgIPhoneBg)
            make.left.equalTo(imgIPhoneBg)
            make.top.equalTo(imgIPhoneBg.snp_bottom).offset(SCREEN_SCALE_HEIGHT * (margin * 2))
            make.right.equalTo(self).offset(SCREEN_SCALE_WIDTH * -250)
        }
        
        txtInputVerifty.snp_makeConstraints { (make) in
            make.height.equalTo(imgVerifyBg)
            make.centerY.equalTo(imgVerifyBg)
            make.right.equalTo(imgVerifyBg)
            make.left.equalToSuperview().offset(SCREEN_SCALE_WIDTH * alertSize)
        }
        
        lblVerify.snp_makeConstraints { (make) in
            make.height.equalTo(imgVerifyBg)
            make.left.equalTo(imgVerifyBg)
            make.centerY.equalTo(imgVerifyBg)
            make.right.equalTo(txtInputVerifty.snp_left)
        }
        
        btnSendVerify.snp_makeConstraints { (make) in
            make.height.equalTo(imgVerifyBg)
            make.centerY.equalTo(imgVerifyBg)
            make.left.equalTo(imgVerifyBg.snp_right).offset(SCREEN_SCALE_WIDTH * margin)
            make.right.equalTo(imgIPhoneBg)
        }
        
        imgPasswordBg.snp_makeConstraints { (make) in
            make.top.equalTo(imgVerifyBg.snp_bottom).offset(SCREEN_SCALE_HEIGHT * (margin * 2))
            make.left.right.equalTo(imgIPhoneBg)
            make.height.equalTo(imgVerifyBg)
        }
        
        txtInputPassword.snp_makeConstraints { (make) in
            make.height.equalToSuperview()
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview().offset(SCREEN_SCALE_WIDTH * alertSize)
        }
        
        lblPassword.snp_makeConstraints { (make) in
            make.height.equalTo(imgPasswordBg)
            make.centerY.equalTo(imgPasswordBg)
            make.left.equalTo(imgPasswordBg)
            make.right.equalTo(txtInputPassword.snp_left)
        }
        
        btnSubmit.snp_makeConstraints { (make) in
            make.top.equalTo(imgPasswordBg.snp_bottom).offset(SCREEN_SCALE_HEIGHT * (margin * 2))
            make.size.equalTo(imgPasswordBg)
            make.centerX.equalTo(imgPasswordBg)
        }
        
    }
    
    /** 统一设置label的样式 */
    private func setLabel(lbl: UILabel, lblText: String, color: UIColor, alignment: NSTextAlignment, fontSize: CGFloat) -> UILabel {
        lbl.textAlignment = alignment
        lbl.text = lblText
        lbl.textColor = color
        lbl.font = UIFont.systemFontOfSize(fontSize)
        return lbl
    }
    
    /** 自定义导航栏 */
    private lazy var navView: UIView = {
        let nav = UIView()
        nav.layer.contents = UIImage(named: "03委员读书_02")?.CGImage
        return nav
    }()
    /** 导航栏标题 */
    private lazy var title: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.whiteColor()
        title.text = "短信验证登录"
        title.font = UIFont.boldSystemFontOfSize(20)
        return title
    }()
    /** 退出按钮 */
    lazy var btnBack: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "委员笔记_06"), forState: .Normal)
        return btn
    }()
    /** 提示输入标签 */
    private lazy var lblInputAlert: UILabel = {
        let inputAlert = UILabel()
//        inputAlert.text = "请输入手机号:"
//        inputAlert.textColor = ZJGlobalBlackBlueColor()
//        inputAlert.font = UIFont.systemFontOfSize(20)
        return inputAlert
    }()
    
    /** 手机号背景 */
    private lazy var imgIPhoneBg: UIImageView = {
        let imgIPhoneBg = UIImageView()
        imgIPhoneBg.layer.borderWidth = 2
        imgIPhoneBg.layer.borderColor = UIColor.colorWithString("#aeb2b8").CGColor
        imgIPhoneBg.layer.cornerRadius = 5
        imgIPhoneBg.userInteractionEnabled = true
        return imgIPhoneBg
    }()
    
    /** 手机区号 */
    lazy var lblIPhoneID: UILabel = {
        let iphoneID = UILabel()
        iphoneID.text = "(+86)"
        iphoneID.textAlignment = .Center
        return iphoneID
    }()
    
    /** 手机号输入 */
    lazy var txtIPhone: UITextField = {
        let iphone = UITextField()
        iphone.keyboardType = .PhonePad
        iphone.placeholder = "请输入手机号"
        return iphone
    }()
    
    /** 验证背景 */
    private lazy var imgVerifyBg: UIImageView = {
        let verifyBg = UIImageView()
        verifyBg.layer.borderWidth = 2
        verifyBg.layer.borderColor = UIColor.colorWithString("#aeb2b8").CGColor
        verifyBg.layer.cornerRadius = 5
        verifyBg.userInteractionEnabled = true
        return verifyBg
    }()
    
    /** 验证码提示 */
    private lazy var lblVerify: UILabel = {
        let verify = UILabel()
        return verify
    }()
    
    /** 验证码 */
    lazy var txtInputVerifty: UITextField = {
        let inputVerify = UITextField()
        inputVerify.keyboardType = .PhonePad
        inputVerify.placeholder = "请输入验证码"
        return inputVerify
    }()
    
    /** 获取验证按钮 */
    lazy var btnSendVerify: UIButton = {
        let btnsendverify = UIButton()
        btnsendverify.titleLabel?.font = UIFont.systemFontOfSize(14)
        btnsendverify.layer.cornerRadius = 5
        btnsendverify.backgroundColor = UIColor.colorWithString("#aeb2b8")
        btnsendverify.setTitle("发送验证码", forState: .Normal)
        return btnsendverify
    }()
    
    /** 密码背景 */
    private lazy var imgPasswordBg: UIImageView = {
        let imgpasswordBg = UIImageView()
        imgpasswordBg.layer.borderWidth = 2
        imgpasswordBg.layer.borderColor = UIColor.colorWithString("#aeb2b8").CGColor
        imgpasswordBg.layer.cornerRadius = 5
        imgpasswordBg.userInteractionEnabled = true
        return imgpasswordBg
    }()
    
    /** 密码提示 */
    private lazy var lblPassword: UILabel = {
        let password = UILabel()
        return password
    }()
    
    /** 密码 */
    lazy var txtInputPassword: UITextField = {
        let inputPassword = UITextField()
        inputPassword.secureTextEntry = true
        inputPassword.placeholder = "请输入密码"
        return inputPassword
    }()
    
    /** 提交按钮 */
    lazy var btnSubmit: UIButton = {
        let submit = UIButton()
        submit.layer.cornerRadius = 5
        submit.backgroundColor = ZJColor(63, g: 86, b: 145, a: 1)
        submit.setTitle("提交", forState: .Normal)
        submit.enabled = false
        return submit
    }()
    
}
