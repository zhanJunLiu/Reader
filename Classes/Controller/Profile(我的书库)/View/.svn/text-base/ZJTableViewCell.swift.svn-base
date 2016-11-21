//
//  ZJTableViewCell.swift
//  Book
//
//  Created by mac on 16/9/12.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class ZJTableViewCell: UITableViewCell {

    
    var models : ZJSettingModel? {
        didSet{
            imgV.image = UIImage(named: models!.img ?? "")
            titlel.text = models!.title
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
    
        addSubview(imgV)
        addSubview(titlel)
        addSubview(switchs)
        addSubview(lineView)
        
        imgV.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(contentView).offset(SCREEN_SCALE_WIDTH * 40)
            make.size.equalTo(CGSizeMake(SCREEN_SCALE_WIDTH * 40, SCREEN_SCALE_HEIGHT * 40))
        }
        
        titlel.snp_makeConstraints { (make) in
            make.centerY.equalTo(imgV)
            make.left.equalTo(imgV.snp_right).offset(SCREEN_SCALE_WIDTH * 20)
        }
        
        switchs.snp_makeConstraints { (make) in
            make.centerY.equalTo(titlel)
            make.right.equalTo(contentView).offset(SCREEN_SCALE_WIDTH * -40)
        }
        
        lineView.snp_makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.left.right.equalTo(self)
            make.height.equalTo(2)
        }
        
    }
    
    private lazy var imgV: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "sosuo")
        return img
    }()
    
    private lazy var titlel: UILabel = {
        let tit = UILabel()
        tit.text = "hello world"
        return tit
    }()
    
    lazy var switchs: UISwitch = {
        let swich = UISwitch()
        swich.hidden = true
        return swich
    }()
    
    private lazy var lineView: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.grayColor()
        return line
    }()
}
