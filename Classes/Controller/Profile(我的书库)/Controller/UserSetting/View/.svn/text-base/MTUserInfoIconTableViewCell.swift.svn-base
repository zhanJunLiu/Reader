//
//  MTIconTableViewCell.swift
//  art-teacher
//
//  Created by 路政浩 on 16/8/1.
//  Copyright © 2016年 com.etudetime. All rights reserved.
//

import UIKit

class MTUserInfoIconTableViewCell: UITableViewCell {
    
    /** 头像图片*/
    var UserInfoIcon:UIImageView = UIImageView()
  
//    /** 头像名*/
//    private lazy var UserInfoName : UILabel = {
//        let UserName = UILabel()
//        UserName.setText("头像", font: UIFont.systemFontOfSize(17), color: UIColor.blackColor())
//        return UserName
//    }()
    
//    /** 箭头*/
//    private lazy var UserInfoArrow : UIImageView = {
//        let arrowIcon = UIImageView()
//        
//        arrowIcon.image = UIImage(named: "Login_03" )
//        return arrowIcon
//    }()
    
    /** cell下面的线*/
    private lazy var LineIcon : UIView = {
        var lineIcon = UIView()
        lineIcon.alpha = 0.5
        lineIcon.backgroundColor = UIColor.lightGrayColor()
        return lineIcon
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        
        /** 设置头像信息*/
        setUserInfoIcon()
    }
    
    func setUserInfoIcon() {
        UserInfoIcon.layer.cornerRadius = 5
        UserInfoIcon.backgroundColor = kTopicColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
extension MTUserInfoIconTableViewCell {
    private func setUI(){
//        contentView.addSubview(UserInfoName)
        
//        contentView.addSubview(UserInfoArrow)
        
        contentView.addSubview(UserInfoIcon)
        
        contentView.addSubview(LineIcon)
        
//        UserInfoName.snp_makeConstraints { (make) in
//            make.left.equalTo(contentView.snp_left).offset(15)
//            make.centerY.equalTo(contentView.snp_centerY)
//        }
//        UserInfoArrow.snp_makeConstraints { (make) in
//            make.centerY.equalTo(contentView.snp_centerY)
//            make.right.equalTo(contentView.snp_right).offset(-15)
//            make.width.equalTo(10)
//            make.height.equalTo(15)
//        }
        
//        UserInfoIcon.snp_makeConstraints { (make) in
//            make.centerY.equalTo(contentView.snp_centerY)
//            make.right.equalTo(UserInfoArrow.snp_right).offset(-20)
//            make.width.equalTo(65)
//            make.height.equalTo(65)
//        }
        UserInfoIcon.snp_makeConstraints { (make) in
            make.center.equalTo(contentView)
            make.size.equalTo(CGSizeMake(SCREEN_SCALE_WIDTH * 180, SCREEN_SCALE_HEIGHT * 180))
        }
        
        
        
        LineIcon.snp_makeConstraints { (make) in
            make.left.equalTo(contentView.snp_left).offset(15)
            make.right.equalTo(contentView.snp_right)
            make.bottom.equalTo(contentView.snp_bottom)
            make.height.equalTo(0.3)
        }
    }
    
}