//
//  ZJHeaderView.swift
//  Book
//
//  Created by mac on 16/9/12.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

/** 左右间距 */
private let leftAndRight: CGFloat = 50

/** 头部间距 */
private let top:          CGFloat = 30

/** 按钮大小 */
private let anNiuSize:         CGFloat = 45

class ZJHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        addSubview(headerButton)
        addSubview(moreButton)
        addSubview(searchButton)
        addSubview(lblTitle)
        headerButton.snp_makeConstraints { (make) in
            make.size.equalTo(self)
            make.center.equalTo(self)
        }
        self.bringSubviewToFront(moreButton)
        self.bringSubviewToFront(searchButton)
        
        moreButton.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(SCREEN_SCALE_WIDTH * anNiuSize, SCREEN_SCALE_HEIGHT * anNiuSize))
            make.top.equalTo(self).offset(SCREEN_SCALE_HEIGHT * top)
            make.left.equalTo(self).offset(SCREEN_SCALE_WIDTH * leftAndRight)
        }
        
        searchButton.snp_makeConstraints { (make) in
            make.size.equalTo(moreButton)
            make.top.equalTo(moreButton)
            make.right.equalTo(self).offset(SCREEN_SCALE_WIDTH * -leftAndRight)
        }
        
        lblTitle.snp_makeConstraints { (make) in
            make.centerY.equalTo(searchButton)
            make.centerX.equalTo(self)
        }
    }
    
    private lazy var lblTitle: UILabel = {
        let title = UILabel()
        
        title.textColor = UIColor.whiteColor()
//        title.font = UIFont.boldSystemFontOfSize(18)
//        title.font = UIFont(name: "Hiragino Sans", size: 60 * pxSizePt)
        return title
    }()
    
    lazy var headerButton: UIButton = {
        let header = UIButton()
        header.setImage(UIImage(named: ""), forState: .Normal)
        return header
    }()
    
    lazy var moreButton: UIButton = {
        let more = UIButton()
        more.setImage(UIImage(named: "xiaoxi4"), forState: .Normal)
        return more
    }()
    
    lazy var searchButton: UIButton = {
        let search = UIButton()
        search.setImage(UIImage(named: "sosuo"), forState: .Normal)
        return search
    }()
}
