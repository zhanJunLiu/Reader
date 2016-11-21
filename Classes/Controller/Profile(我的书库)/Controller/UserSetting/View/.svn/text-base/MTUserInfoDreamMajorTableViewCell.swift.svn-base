//
//  MTUserInfoDreamMajorTableViewCell.swift
//  art-teacher
//
//  Created by 路政浩 on 16/8/3.
//  Copyright © 2016年 com.etudetime. All rights reserved.
//

import UIKit

class MTUserInfoDreamMajorTableViewCell: UITableViewCell {
    
    /** 理想专业名字*/
    var UserInfoDreamMajorName = UITextField()
    
   
  
    
    
    
    /** 理想专业标题*/
    private lazy var UserInfoDreamMajorTitle : UILabel = {
        let UserInfoDreamMajorTitle = UILabel()
        
        UserInfoDreamMajorTitle.setText("理想专业", font: UIFont.systemFontOfSize(17), color: UIColor.blackColor())
        return UserInfoDreamMajorTitle
    }()
       override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        
        /** 设置理想专业信息*/
        setUserInfoDreamMajorName()
    }
    
    func setUserInfoDreamMajorName() {
        UserInfoDreamMajorName.textAlignment = .Right
        UserInfoDreamMajorName.keyboardType = .NamePhonePad
        UserInfoDreamMajorName.borderStyle = .None
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
extension MTUserInfoDreamMajorTableViewCell {
    
    private func setUI(){
        contentView.addSubview(UserInfoDreamMajorTitle)
        contentView.addSubview(UserInfoDreamMajorName)
        
        UserInfoDreamMajorTitle.snp_makeConstraints { (make) in
            make.left.equalTo(contentView.snp_left).offset(15)
            make.centerY.equalTo(contentView.snp_centerY)
        }
        
        UserInfoDreamMajorName.snp_makeConstraints { (make) in
            make.right.equalTo(contentView.snp_right).offset(-15)
            make.top.equalTo(contentView.snp_top)
            make.bottom.equalTo(contentView.snp_bottom)
            make.width.equalTo(200)
        }
    }
    
}