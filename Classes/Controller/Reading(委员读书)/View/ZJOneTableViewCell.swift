//
//  ZJOneTableViewCell.swift
//  CHReadingBook
//
//  Created by mac on 16/9/19.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

/** 标题文字大小 */
private let titleSize: CGFloat = 16

/** 书源文字大小 */
private let shuPinSize: CGFloat = 12

class ZJOneTableViewCell: UITableViewCell {

    var models: CHReadingHeader?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
    
        contentView.addSubview(bgImageView)
        bgImageView.snp_makeConstraints { (make) in
            make.top.equalTo(contentView).offset(SCREEN_SCALE_HEIGHT * 20)
            make.left.equalTo(contentView).offset(SCREEN_SCALE_WIDTH * 20)
            make.bottom.equalTo(contentView).offset(SCREEN_SCALE_HEIGHT * -10)
            make.right.equalTo(contentView).offset(SCREEN_SCALE_WIDTH * -20)
        }
      
        bgImageView.addSubview(imgIcon)
        imgIcon.snp_makeConstraints { (make) in
            make.right.equalTo(bgImageView).offset(SCREEN_SCALE_WIDTH * -20)
            make.bottom.equalTo(bgImageView).offset(SCREEN_SCALE_HEIGHT * -20)
            make.width.equalTo(SCREEN_SCALE_WIDTH * 220)
            make.height.equalTo(SCREEN_SCALE_HEIGHT * 340)
        }
        
        bgImageView.addSubview(lblShuPin)
        lblShuPin.snp_makeConstraints { (make) in
            make.bottom.equalTo(bgImageView).offset(SCREEN_SCALE_HEIGHT * -20)
            make.left.equalTo(bgImageView).offset(SCREEN_SCALE_WIDTH * 20)
        }
        
        bgImageView.addSubview(lblTitle)
        lblTitle.snp_makeConstraints { (make) in
            make.left.equalTo(lblShuPin)
            make.bottom.equalTo(lblShuPin.snp_top).offset(SCREEN_SCALE_HEIGHT * -20)
            make.right.equalTo(imgIcon.snp_left).offset(SCREEN_SCALE_WIDTH * -20)
        }
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgImageView.yy_setImageWithURL(NSURL(string: "\(BASE_URL)\(models?.committee_bgpic ?? "")"), placeholder: UIImage(named: "占位图"))
        imgIcon.yy_setImageWithURL(NSURL(string: "\(BASE_URL)\(models?.book_pic ?? "")"), placeholder: UIImage(named: "tuzuo"))
        imgIcon.layer.shadowOpacity = 0.5
        imgIcon.layer.shadowColor = UIColor.blackColor().CGColor
        imgIcon.layer.shadowOffset = CGSize(width: 1, height: 1)
        lblTitle.text = models?.book_name
//        print(UIFont.familyNames())
        lblTitle.font = UIFont(name: "Hiragino Sans", size: 62 * pxSizePt)
        lblShuPin.text = models?.committee_ren_name ?? ""
        lblShuPin.font = UIFont(name: "Hiragino Sans", size: 41 * pxSizePt)
    }
    
    private lazy var bgImageView: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = UIColor.whiteColor()
        img.layer.cornerRadius = 5
        img.layer.masksToBounds = true
        return img
    }()
    
    private lazy var imgIcon: UIImageView = {
        let icon = UIImageView()
        icon.backgroundColor = UIColor.redColor()
        return icon
    }()
    
    private lazy var lblTitle: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.whiteColor()
        title.font = UIFont.systemFontOfSize(titleSize)
        return title
    }()
    
    private lazy var lblShuPin: UILabel = {
        let shupin = UILabel()
        shupin.textColor = UIColor.whiteColor()
        shupin.font = UIFont.systemFontOfSize(shuPinSize)
        return shupin
    }()
}
