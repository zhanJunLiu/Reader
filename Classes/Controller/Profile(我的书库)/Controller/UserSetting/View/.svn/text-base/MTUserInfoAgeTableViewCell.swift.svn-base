//
//  MTUserInfoAgeTableViewCell.swift
//  art-teacher
//
//  Created by 路政浩 on 16/8/1.
//  Copyright © 2016年 com.etudetime. All rights reserved.
//

import UIKit

class MTUserInfoAgeTableViewCell: UITableViewCell {
    
    /** 年龄*/
    var UserInfoBirthName = UILabel()
    
    
    
    
    
    
    /** 年龄标题*/
    private lazy var UserInfoBirthTitle : UILabel = {
        let UserInfoBirthTitle = UILabel()
        UserInfoBirthTitle.setText("年龄", font: UIFont.systemFontOfSize(17), color: UIColor.blackColor())
        return UserInfoBirthTitle
    }()

    /** 箭头*/
    private lazy var UserInfoArrow : UIImageView = {
        let arrowIcon = UIImageView()
        arrowIcon.image = UIImage(named: "箭头icon" )
        return arrowIcon
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        
        /** 设置用户年龄信息*/
        setUserInfoBirth()
    }
    func setUserInfoBirth() {
        UserInfoBirthName.textAlignment = .Right
        UserInfoBirthName.setText("0", font: UIFont.systemFontOfSize(17), color: UIColor.blackColor())
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
extension MTUserInfoAgeTableViewCell {
    
    private func setUI(){
        contentView.addSubview(UserInfoBirthTitle)
        contentView.addSubview(UserInfoBirthName)
        contentView.addSubview(UserInfoArrow)
        
        UserInfoBirthTitle.snp_makeConstraints { (make) in
            make.left.equalTo(contentView.snp_left).offset(15)
            make.centerY.equalTo(contentView.snp_centerY)
        }
        UserInfoBirthName.snp_makeConstraints { (make) in
            make.right.equalTo(UserInfoArrow.snp_left).offset(-10)
            make.top.equalTo(contentView.snp_top).offset(0)
            make.bottom.equalTo(contentView.snp_bottom).offset(0)
            make.width.equalTo(100)
        }
        UserInfoArrow.snp_makeConstraints { (make) in
            make.centerY.equalTo(contentView.snp_centerY)
            make.right.equalTo(contentView.snp_right).offset(-15)
            make.width.equalTo(10)
            make.height.equalTo(15)
        }
        
    }
    
}