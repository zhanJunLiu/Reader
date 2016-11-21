//
//  ZJMineHeaderView.swift
//  Scholar
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

private let kLeftAndRightMargin: CGFloat = 80.0

class ZJMineHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        addSubview(bgImageView)
        addSubview(settingButton)
        addSubview(messageButton)
        addSubview(iconButton)
        addSubview(nameLabel)
        
        // 布局
        bgImageView.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(self)
            make.top.equalTo(-20)
        }
        
        settingButton.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(btnSize, btnSize))
            make.left.equalTo(iconButton.snp_right).offset(SCREEN_SCALE_WIDTH * kLeftAndRightMargin)
            make.centerY.equalTo(iconButton)
        }
        
        messageButton.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(btnSize, btnSize))
            make.centerY.equalTo(iconButton)
            make.right.equalTo(iconButton.snp_left).offset(SCREEN_SCALE_WIDTH * -kLeftAndRightMargin)
        }
        
        iconButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.centerX)
            make.size.equalTo(CGSizeMake(headSize, headSize))
            make.bottom.equalTo(nameLabel.snp_top).offset(-kMargin)
        }
        
        nameLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.snp_bottom).offset(-3 * kMargin)
            make.left.right.equalTo(self)
            make.height.equalTo(2 * kMargin)
        }
    }
    
    /// 懒加载背景图片
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.contentMode = .ScaleAspectFill
        bgImageView.image = UIImage(named: "gerenzhongxin-background")
        return bgImageView
    }()
    
    /// 左上角消息按钮
    lazy var messageButton: UIButton = {
        let messageButton = UIButton()
        messageButton.setImage(UIImage(named: "shoucangjia_241_470"), forState: .Normal)
        return messageButton
    }()
    
    /// 懒加载，创建左上角消息按钮
    lazy var settingButton: UIButton = {
        let settingButton = UIButton()
        settingButton.setImage(UIImage(named: "shezhi_898_470"), forState: .Normal)
        return settingButton
    }()
    
    /// 懒加载，创建头像按钮
    lazy var iconButton: UIButton = {
        let iconButton = UIButton()
        iconButton.setBackgroundImage(UIImage(named: "loginIcon"), forState: .Normal)
        iconButton.setImage(UIImage(named: "dengluqian430_292"), forState: UIControlState.Normal)
        iconButton.layer.cornerRadius = iconButton.width * 0.5
        iconButton.layer.masksToBounds = true
        return iconButton
    }()
    
    /// 懒加载，创建昵称标签
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = ""
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.font = UIFont.systemFontOfSize(15.0)
        nameLabel.textAlignment = .Center
        return nameLabel
    }()

    
}
