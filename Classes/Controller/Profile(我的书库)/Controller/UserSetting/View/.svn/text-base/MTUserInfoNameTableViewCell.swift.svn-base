//
//  MTUserInfoNameTableViewCell.swift
//  art-teacher
//
//  Created by 路政浩 on 16/8/1.
//  Copyright © 2016年 com.etudetime. All rights reserved.
//

import UIKit

class MTUserInfoNameTableViewCell: UITableViewCell {
   
    /** 用户名字*/
    var UserInfoName = UITextField()
    
    
    
    
    
    
    /** 名字标题*/
    private lazy var UserInfoNameTile : UILabel = {
        let UserInfoNameTile = UILabel()
        
        UserInfoNameTile.setText("名字", font: UIFont.systemFontOfSize(17), color: UIColor.blackColor())
        return UserInfoNameTile
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
        
        
        /** 设置用户名字信息*/
        setUserInfoName()
        
    }
    func setUserInfoName()  {
        UserInfoName.textAlignment = .Right
        UserInfoName.keyboardType = .NamePhonePad
        UserInfoName.borderStyle = .None
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
extension MTUserInfoNameTableViewCell {
    
    private func setUI(){
        contentView.addSubview(UserInfoNameTile)
        contentView.addSubview(UserInfoName)
        contentView.addSubview(LineIcon)
        
        UserInfoNameTile.snp_makeConstraints { (make) in
            make.left.equalTo(contentView.snp_left).offset(15)
            make.centerY.equalTo(contentView.snp_centerY)
        }
        UserInfoName.snp_makeConstraints { (make) in
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