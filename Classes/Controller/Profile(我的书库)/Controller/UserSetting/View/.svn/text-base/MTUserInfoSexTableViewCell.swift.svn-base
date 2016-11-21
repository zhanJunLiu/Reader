//
//  MTUserInfoSexTableViewCell.swift
//  art-teacher
//
//  Created by 路政浩 on 16/8/1.
//  Copyright © 2016年 com.etudetime. All rights reserved.
//

import UIKit

class MTUserInfoSexTableViewCell: UITableViewCell {
 
    /** 性别*/
    var UserInfoSex: UILabel = UILabel()
    
    var index : NSInteger? {
        didSet{
            
            print("cell中的性别表示付: \(index)")
            
        }
    }
    
    
    
    /** 性别标题*/
    private lazy var UserInfoSexTitle : UILabel = {
        let UserInfoSexTitle = UILabel()
        
        UserInfoSexTitle.setText("性别", font: UIFont.systemFontOfSize(17), color: UIColor.blackColor())
        return UserInfoSexTitle
    }()
    
    /** 用户箭头*/
    private lazy var UserInfoArrow : UIImageView = {
        let arrowIcon = UIImageView()
        
        arrowIcon.image = UIImage(named: "箭头icon" )
        return arrowIcon
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
        /** 设置用户性别信息*/
        setUserInfoSex()
    }
    
    func setUserInfoSex() {
        UserInfoSex.textAlignment = .Right
        UserInfoSex.setText("男", font: UIFont.systemFontOfSize(17), color: UIColor.blackColor())
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
extension MTUserInfoSexTableViewCell {
    
    private func setUI(){
        contentView.addSubview(UserInfoSexTitle)
        contentView.addSubview(UserInfoArrow)
        contentView.addSubview(UserInfoSex)
        contentView.addSubview(LineIcon)
        
        UserInfoSexTitle.snp_makeConstraints { (make) in
            make.left.equalTo(contentView.snp_left).offset(15)
            make.centerY.equalTo(contentView.snp_centerY)
        }
        
        UserInfoArrow.snp_makeConstraints { (make) in
            make.centerY.equalTo(contentView.snp_centerY)
            make.right.equalTo(contentView.snp_right).offset(-15)
            make.width.equalTo(10)
            make.height.equalTo(15)
        }
        
        UserInfoSex.snp_makeConstraints { (make) in
            make.right.equalTo(UserInfoArrow.snp_left).offset(-10)
            make.top.equalTo(contentView.snp_top).offset(0)
            make.bottom.equalTo(contentView.snp_bottom).offset(0)
            make.width.equalTo(50)
        }
        
        LineIcon.snp_makeConstraints { (make) in
            make.left.equalTo(contentView.snp_left).offset(15)
            make.right.equalTo(contentView.snp_right)
            make.bottom.equalTo(contentView.snp_bottom)
            make.height.equalTo(0.3)
        }
    }
    
}