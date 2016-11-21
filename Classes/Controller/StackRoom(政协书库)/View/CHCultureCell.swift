//
//  CHCultureCell.swift
//  CHReadingBook
//
//  Created by macbook on 2016/11/18.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class CHCultureCell: UICollectionViewCell {
    
    var imgView: UIImageView?
    var imgTitle: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        print("cell 的高度: \(self.frame.size.height)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 186.333333333333
    
    private func setupUI() {
        
        imgView = UIImageView()
        imgView!.layer.shadowOpacity = 0.5
        imgView!.layer.shadowColor = UIColor.blackColor().CGColor
        imgView!.layer.shadowOffset = CGSize(width: 1, height: 1)
        contentView.addSubview(imgView!)
        imgView!.backgroundColor = UIColor.redColor()
        imgView!.snp_makeConstraints { (make) in
            make.left.equalTo(contentView).offset(SCREEN_SCALE_WIDTH * 43)
            make.right.equalTo(contentView).offset(SCREEN_SCALE_WIDTH * -41)
            make.top.equalTo(contentView).offset(SCREEN_SCALE_HEIGHT * 56)
            make.bottom.equalTo(contentView).offset(SCREEN_SCALE_HEIGHT * -87)
        }
        
        imgTitle = UILabel()
        contentView.addSubview(imgTitle!)
        imgTitle?.text = "书名标题"
        imgTitle?.textAlignment = .Center
        imgTitle?.font = UIFont(name: "Hiragino Sans", size: 42 * pxSizePt)
        imgTitle?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(imgView!.snp_bottom).offset(SCREEN_SCALE_HEIGHT * 25)
            make.left.right.equalTo(contentView)
        })
    }
}
