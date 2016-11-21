//
//  ZJMineFooterView.swift
//  Scholar
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

protocol ZJMineFooterViewDelegate: NSObjectProtocol {
    func didClickFooterButton()
}

class ZJMineFooterView: UIView {
    
    weak var delegate: ZJMineFooterViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(meBlankButton)
        
        addSubview(messageLabel)
        
        meBlankButton.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(50, 50))
//            make.center.equalTo(self.center)
            make.top.equalTo(50)
            make.centerX.equalTo(self.centerX)
        }
        
        messageLabel.snp_makeConstraints { (make) in
            make.top.equalTo(meBlankButton.snp_bottom).offset(kMargin)
            make.left.right.equalTo(self)
        }

    }
    
    private lazy var meBlankButton: UIButton = {
        let meBlankButton = UIButton()
        meBlankButton.setTitleColor(ZJColor(200, g: 200, b: 200, a: 1.0), forState: .Normal)
        meBlankButton.width = 100
        meBlankButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        meBlankButton.setImage(UIImage(named: "占位图"), forState: .Normal)
        meBlankButton.addTarget(self, action: #selector(footerViewButtonClick), forControlEvents: .TouchUpInside)
        meBlankButton.imageView?.sizeToFit()
        return meBlankButton
    }()
    
    private lazy var messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.text = "登录以享受功能"
        messageLabel.textAlignment = .Center
        messageLabel.font = UIFont.systemFontOfSize(15)
        messageLabel.textColor = ZJColor(200, g: 200, b: 200, a: 1.0)
        return messageLabel
    }()
    
    func footerViewButtonClick() {
        
        self.delegate?.didClickFooterButton()
    }

    
}
