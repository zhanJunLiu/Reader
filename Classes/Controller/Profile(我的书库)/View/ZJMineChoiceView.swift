//
//  ZJMineChoiceView.swift
//  Scholar
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class ZJMineChoiceView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        // 左边的按钮
        addSubview(leftButton)
        // 右边的按钮
        addSubview(rightButton)
        // 底部红色条
        addSubview(indicatorView)
        
        leftButton.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(rightButton)
        }
        
        rightButton.snp_makeConstraints { (make) in
            make.left.equalTo(leftButton.snp_right)
            make.top.right.bottom.equalTo(self)
        }
        
        indicatorView.snp_makeConstraints { (make) in
            make.height.equalTo(kIndicatorViewH)
            make.top.left.equalTo(self)
            make.right.equalTo(leftButton)
        }
    }
    /// 左边的按钮
    private lazy var leftButton: UIButton = {
        let leftButton = UIButton()
        leftButton.setTitle("书架", forState: .Normal)
        leftButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        leftButton.setTitleColor(ZJGlobalRedColor(), forState: .Normal)
        
        leftButton.backgroundColor = UIColor.whiteColor()
        leftButton.addTarget(self, action: #selector(leftButtonClick(_:)), forControlEvents: .TouchUpInside)
        leftButton.layer.borderColor = ZJColor(230, g: 230, b: 230, a: 1.0).CGColor
        leftButton.layer.borderWidth = klineWidth
        leftButton.selected = true
        return leftButton
    }()
    
    /// 右边的按钮
    private lazy var rightButton: UIButton = {
        let rightButton = UIButton()
        rightButton.setTitle("收藏", forState: .Normal)
        rightButton.setTitleColor(ZJColor(0, g: 0, b: 0, a: 0.7), forState: .Normal)
        rightButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        rightButton.backgroundColor = UIColor.whiteColor()
        rightButton.addTarget(self, action: #selector(rightButtonClick(_:)), forControlEvents: .TouchUpInside)
        rightButton.layer.borderColor = ZJColor(230, g: 230, b: 230, a: 1.0).CGColor
        rightButton.layer.borderWidth = klineWidth
        return rightButton
    }()
    
    /// 底部红色条
    private lazy var indicatorView: UIView = {
        let indicatorView = UIView()
        indicatorView.backgroundColor = ZJGlobalRedColor()
        return indicatorView
    }()
    
    func leftButtonClick(button: UIButton) {
        print("666666666")
        button.selected = !button.selected
        UIView.animateWithDuration(kAnimationDuration, animations: {
            self.indicatorView.x = 0
        }) { (false) in
            button.setTitleColor(UIColor.redColor(), forState: .Normal)
            self.rightButton.titleLabel?.textColor = UIColor.blackColor()
        }
    }
    
    func rightButtonClick(button: UIButton) {
        print("99999999")
        button.selected = !button.selected
        UIView.animateWithDuration(kAnimationDuration, animations: {
            self.indicatorView.x = SCREEN_W * 0.5
        }) { (false) in
            button.setTitleColor(UIColor.redColor(), forState: .Normal)
            self.leftButton.titleLabel?.textColor = UIColor.blackColor()
        }
    }
}
