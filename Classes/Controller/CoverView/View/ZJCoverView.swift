//
//  ZJCoverView.swift
//  CHReadingBook
//
//  Created by mac on 16/9/17.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

/// 标题文字大小
private let titleSize: CGFloat = 16

/// 作者文字大小
private let nameSize:  CGFloat = 14

/// 购买文字大小
private let moneySize: CGFloat = 15

class ZJCoverView: UIView {

    var bgView :        UIView!      /** 小背景view */
    var imgView:        UIImageView! /** 图片 */
    var lblTitle:       UILabel!     /** 书名 */
    var name:           UILabel!     /** 作者 */
    var imgReading:     UIImageView! /** 阅读人数图标 */
    var lblReading:     UILabel!     /** 阅读人数 */
    var imgFileSize:    UIImageView! /** 文件大小图片 */
    var lblFileSize:    UILabel!     /** 文件大小 */
    var shoppingCar:    UIButton!    /** 购物车 */
    var books:          UIButton!    /** 加入书架 */
    var jianJie:        UILabel!     /** 简介 */
    var jianJieContent: UITextView!  /** 简介内容 */
    var btnMoney:       UIButton!    /** 购买钱数 */
    
    init(frame: CGRect, imageName: String, title: String, author: String, readingCount: String, fileSize: String, description: String, money: String) {
        super.init(frame: frame)
        setupUI(frame, imageName: imageName, title: title, author: author, readingCount: readingCount, fileSize: fileSize, description: description, money: money)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(frame: CGRect, imageName: String, title: String, author: String, readingCount: String, fileSize: String, description: String, money: String) {
        
        self.backgroundColor = ZJColor(0, g: 0, b: 0, a: 0.9)
        bgView = UIButton()
        bgView.backgroundColor = UIColor.whiteColor()
        bgView.userInteractionEnabled = true
        addSubview(bgView)
        bgView.snp_makeConstraints { (make) in
            make.center.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.7)
            make.width.equalTo(self).multipliedBy(0.8)
        }
        
        imgView = UIImageView()
        imgView.yy_imageURL = NSURL(string: "\(BASE_URL)\(imageName)")
        bgView.addSubview(imgView)
        imgView.layer.cornerRadius = 5
        imgView.layer.masksToBounds = true
        imgView.snp_makeConstraints { (make) in
            make.top.equalTo(bgView).offset(SCREEN_SCALE_HEIGHT * 30)
            make.left.equalTo(bgView).offset(SCREEN_SCALE_WIDTH * 30)
            make.right.equalTo(bgView.snp_centerX).offset(SCREEN_SCALE_WIDTH * -40)
            make.height.equalTo(SCREEN_SCALE_HEIGHT * 300)
        }
        
        lblTitle = UILabel()
        lblTitle.font = UIFont(name: "Hiragino Sans", size: pxSizePt * 60)
        lblTitle.textColor = UIColor.colorWithString("#010101")
        lblTitle.text = title
        bgView.addSubview(lblTitle)
        lblTitle.snp_makeConstraints { (make) in
            make.top.equalTo(imgView)
            make.left.equalTo(bgView.snp_centerX).offset(SCREEN_SCALE_WIDTH * 5)
            make.right.equalTo(bgView).offset(SCREEN_SCALE_WIDTH * -30)
        }
        
        btnMoney = UIButton(ch_title: "¥ \(money)购买", fontSize: moneySize, color: UIColor.colorWithString("#ffffff"), imageName: nil, backImageName: "goumai", backColor: nil)
        bgView.addSubview(btnMoney)
        btnMoney.snp_makeConstraints { (make) in
            make.bottom.left.right.equalTo(bgView)
            make.height.equalTo(SCREEN_SCALE_HEIGHT * 70)
        }
        
        name = UILabel()
        name.font = UIFont(name: "Hiragino Sans", size: pxSizePt * 45)
        name.textColor = UIColor.colorWithString("#ababab")
        name.text = author
        bgView.addSubview(name)
        name.snp_makeConstraints { (make) in
            make.top.equalTo(lblTitle.snp_bottom).offset(SCREEN_SCALE_HEIGHT * 10)
            make.left.equalTo(lblTitle)
            make.right.equalToSuperview().offset(SCREEN_SCALE_WIDTH * -30)
        }
        
        shoppingCar = UIButton(ch_title: "试读", fontSize: 14, color: UIColor.whiteColor(), imageName: nil, backImageName: nil, backColor: kCoverColor)
        bgView.addSubview(shoppingCar)
        shoppingCar.layer.cornerRadius = 3
        shoppingCar.snp_makeConstraints { (make) in
            make.centerY.equalTo(imgView.snp_bottom)
            make.left.equalTo(name)
            make.width.equalTo(SCREEN_SCALE_WIDTH * 100)
            make.height.equalTo(SCREEN_SCALE_HEIGHT * 50)
        }
        
        books = UIButton(ch_title: "加入书架", fontSize: 14, color: UIColor.whiteColor(), imageName: nil, backImageName: nil, backColor: kSHUJIAColor)
        bgView.addSubview(books)
        books.layer.cornerRadius = 3
        books.snp_makeConstraints { (make) in
            make.centerY.equalTo(shoppingCar)
            make.left.equalTo(shoppingCar.snp_right).offset(SCREEN_SCALE_WIDTH * 10)
            make.height.equalTo(shoppingCar)
            make.right.equalTo(lblTitle)
        }
        
        jianJie = UILabel()
        jianJie.text = "简介"
        jianJie.textColor = UIColor.colorWithString("#040404")
        jianJie.font = UIFont(name: "Hiragino Sans", size: pxSizePt * 56)
        bgView.addSubview(jianJie)
        jianJie.snp_makeConstraints { (make) in
            make.top.equalTo(imgView.snp_bottom).offset(SCREEN_SCALE_HEIGHT * 20)
            make.left.equalTo(imgView)
        }
        
        jianJieContent = UITextView()
        jianJieContent.userInteractionEnabled = false
        jianJieContent.text = description
        jianJieContent.textAlignment = .Left
        jianJieContent.textColor = UIColor.colorWithString("#717171")
        jianJieContent.font = UIFont(name: "Hiragino Sans", size: pxSizePt * 50)
        bgView.addSubview(jianJieContent)
        jianJieContent.snp_makeConstraints { (make) in
            make.top.equalTo(jianJie.snp_bottom).offset(SCREEN_SCALE_HEIGHT * 10)
            make.left.equalTo(jianJie)
            make.right.equalTo(books)
            make.bottom.equalTo(btnMoney.snp_top).offset(SCREEN_SCALE_HEIGHT * -10)
        }
        
        imgFileSize = UIImageView(image: UIImage(named: "neicun_609_707"))
        bgView.addSubview(imgFileSize)
        imgFileSize.snp_makeConstraints { (make) in
            make.bottom.equalTo(shoppingCar.snp_top).offset(SCREEN_SCALE_HEIGHT * -20)
            make.size.equalTo(CGSize(width: SCREEN_SCALE_WIDTH * 40, height: SCREEN_SCALE_HEIGHT * 40))
            make.left.equalTo(shoppingCar)
        }
        
        lblFileSize = UILabel()
        lblFileSize.text = "\(fileSize ?? "")M"
        lblFileSize.font = UIFont(name: "Hiragino Sans", size: pxSizePt * 38)
        lblFileSize.textColor = UIColor.colorWithString("#ababab")
        bgView.addSubview(lblFileSize)
        lblFileSize.snp_makeConstraints { (make) in
            make.centerY.equalTo(imgFileSize)
            make.left.equalTo(imgFileSize.snp_right).offset(SCREEN_SCALE_WIDTH * 10)
        }
        
        imgReading = UIImageView(image: UIImage(named: "xingxing_605_635"))
        bgView.addSubview(imgReading)
        imgReading.snp_makeConstraints { (make) in
            make.bottom.equalTo(imgFileSize.snp_top).offset(SCREEN_SCALE_HEIGHT * -14)
            make.size.equalTo(CGSize(width: SCREEN_SCALE_WIDTH * 40, height: SCREEN_SCALE_HEIGHT * 40))
            make.left.equalTo(imgFileSize)
        }
        
        lblReading = UILabel()
        lblReading.textColor = UIColor.colorWithString("#ababab")
        lblReading.font = UIFont(name: "Hiragino Sans", size: pxSizePt * 40)
        lblReading.text = "\(readingCount ?? "")人阅读"
        bgView.addSubview(lblReading)
        lblReading.snp_makeConstraints { (make) in
            make.centerY.equalTo(imgReading)
            make.left.equalTo(lblFileSize)
        }
    }
}