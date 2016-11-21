//
//  MTUserInfoDreamSchoolTableViewCell.swift
//  art-teacher
//
//  Created by 路政浩 on 16/8/3.
//  Copyright © 2016年 com.etudetime. All rights reserved.
//

import UIKit

class MTUserInfoDreamSchoolTableViewCell: UITableViewCell {
    
    /** 理想学校名字*/
    var UserInfoDreamSchoolName = UITextField()
    
    
    
    
    
    
    /** 理想学校标题*/
    private lazy var UserInfoDreamSchoolTitle : UILabel = {
        let UserInfoDreamSchoolTitle = UILabel()
        
        UserInfoDreamSchoolTitle.setText("理想学校", font: UIFont.systemFontOfSize(17), color: UIColor.blackColor())
        return UserInfoDreamSchoolTitle
    }()
    
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
        
        /** 设置理想学校信息*/
        setUserInfoDreamSchoolName()
    }
    
    func setUserInfoDreamSchoolName() {
        UserInfoDreamSchoolName.textAlignment = .Right
        UserInfoDreamSchoolName.keyboardType = .NamePhonePad
        UserInfoDreamSchoolName.borderStyle = .None
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
extension MTUserInfoDreamSchoolTableViewCell {
    
    private func setUI(){
        contentView.addSubview(UserInfoDreamSchoolTitle)
        contentView.addSubview(UserInfoDreamSchoolName)
        contentView.addSubview(LineIcon)
        
        UserInfoDreamSchoolTitle.snp_makeConstraints { (make) in
            make.left.equalTo(contentView.snp_left).offset(15)
            make.centerY.equalTo(contentView.snp_centerY)
        }
        
        UserInfoDreamSchoolName.snp_makeConstraints { (make) in
            make.right.equalTo(contentView.snp_right).offset(-15)
            make.top.equalTo(contentView.snp_top)
            make.bottom.equalTo(contentView.snp_bottom)
            make.width.equalTo(200)
        }
        
        
        LineIcon.snp_makeConstraints { (make) in
            make.left.equalTo(contentView.snp_left).offset(15)
            make.right.equalTo(contentView.snp_right)
            make.bottom.equalTo(contentView.snp_bottom)
            make.height.equalTo(0.3)
        }
    }
    
}