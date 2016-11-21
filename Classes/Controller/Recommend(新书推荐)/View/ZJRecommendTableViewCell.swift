//
//  ZJRecommendTableViewCell.swift
//  Scholar
//
//  Created by mac on 16/9/5.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
import YYWebImage

class ZJRecommendTableViewCell: UITableViewCell {

    var imgView:    UIImageView!
    
    var lblTitle:   UILabel!
    
    var lblContent: UILabel!
    
    var lblName:       UILabel!
    
    var model:      ZJRecommend!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imgView = UIImageView()
        lblTitle = UILabel()
        lblContent = UILabel()
        lblName = UILabel()
        lblTitle.font = UIFont(name: "Hiragino Sans", size: pxSizePt * 60)
        lblTitle.textColor = UIColor.colorWithString("#454545")
        lblName.font = UIFont(name: "Hiragino Sans", size: pxSizePt * 44)
        lblName.textColor = UIColor.colorWithString("#454545")
        lblContent.font = UIFont(name: "Hiragino Sans", size: pxSizePt * 55)
        lblContent.textColor = UIColor.colorWithString("#454545")
        contentView.addSubview(imgView)
        contentView.addSubview(lblTitle)
        contentView.addSubview(lblContent)
        contentView.addSubview(lblName)
        
        imgView.backgroundColor = UIColor.redColor()
        imgView.layer.shadowOpacity = 0.5
        imgView.layer.shadowColor = UIColor.blackColor().CGColor
        imgView.layer.shadowOffset = CGSize(width: 1, height: 1)
        imgView.snp_makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.top.equalTo(contentView).offset(SCREEN_SCALE_HEIGHT * 20)
            make.left.equalTo(contentView).offset(SCREEN_SCALE_WIDTH * 20)
            make.bottom.equalTo(contentView).offset(SCREEN_SCALE_HEIGHT * -20)
            make.width.equalTo(SCREEN_SCALE_WIDTH * 200)
        }
        
        
        lblTitle.snp_makeConstraints { (make) in
            make.top.equalTo(imgView).offset(SCREEN_SCALE_HEIGHT * 10)
            make.left.equalTo(imgView.snp_right).offset(SCREEN_SCALE_WIDTH * 20)
            make.right.equalTo(contentView).offset(SCREEN_SCALE_WIDTH * -20)
        }
        
        lblContent.snp_makeConstraints { (make) in
            make.bottom.equalTo(imgView).offset(SCREEN_SCALE_HEIGHT * -20)
            make.left.equalTo(lblTitle)
            make.right.equalTo(contentView).offset(SCREEN_SCALE_WIDTH * -20)
            make.height.equalTo(SCREEN_SCALE_HEIGHT * 80)
        }
        
        lblName.snp_makeConstraints { (make) in
            make.top.equalTo(lblTitle.snp_bottom).offset(SCREEN_SCALE_HEIGHT * 20)
            make.left.equalTo(lblTitle)
            make.right.equalTo(lblContent)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imgView.yy_setImageWithURL(NSURL(string: "\(BASE_URL)\(model.book_pic)"), placeholder: UIImage(named: "tuliebiao"))
        lblName.text = model.book_author
        lblTitle.text = model.book_name
        lblContent.text = model.book_description
        
    }
}
