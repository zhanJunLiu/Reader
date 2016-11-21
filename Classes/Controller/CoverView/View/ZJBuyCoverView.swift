//
//  ZJBuyCoverView.swift
//  CHReadingBook
//
//  Created by zhuzi on 2016/11/10.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

/// 标题文字大小
private let titleSize: CGFloat = 16

/// 作者文字大小
private let nameSize:  CGFloat = 14

/// 购买文字大小
private let moneySize: CGFloat = 15

class ZJBuyCoverView: UIView {
    
    var bgView :     UIView!      /** 小背景view */
    
    var imgView:     UIImageView! /** 图片 */
    
    var lblTitle:    UILabel!     /** 书名 */
    
    var name:        UILabel!     /** 作者 */
    
    var imgReading:  UIImageView! /** 阅读人数图标 */
    
    var lblReading:  UILabel!     /** 阅读人数 */
    
    var imgFileSize: UIImageView! /** 文件大小图片 */
    
    var lblFileSize: UILabel!     /** 文件大小 */
    
    var shoppingCar: UIButton!    /** 购物车 */
    
    var books:       UIButton!    /** 加入书架 */
    
    var jianJie:     UILabel!     /** 简介 */
    
    var jianJieContent: UILabel!  /** 简介内容 */
    
    var btnMoney:    UIButton!    /** 购买钱数 */
    
    //    var progress:     UIProgressView! /** 进度 */
    
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
        imgView.backgroundColor = UIColor.redColor()
        imgView.snp_makeConstraints { (make) in
            make.top.equalTo(bgView).offset(SCREEN_SCALE_HEIGHT * 30)
            make.left.equalTo(bgView).offset(SCREEN_SCALE_WIDTH * 30)
            make.right.equalTo(bgView.snp_centerX).offset(SCREEN_SCALE_WIDTH * -20)
            make.height.equalTo(SCREEN_SCALE_HEIGHT * 300)
        }
        
        lblTitle = UILabel(ch_text: title, fontSize: titleSize, color: UIColor.blackColor(), alignment: .Left)
        bgView.addSubview(lblTitle)
        lblTitle.snp_makeConstraints { (make) in
            make.top.equalTo(imgView)
            make.left.equalTo(bgView.snp_centerX).offset(SCREEN_SCALE_WIDTH * 5)
            make.right.equalTo(bgView).offset(SCREEN_SCALE_WIDTH * -30)
            make.height.equalTo(SCREEN_SCALE_HEIGHT * 40)
        }
        
        btnMoney = UIButton(ch_title: "已购买", fontSize: moneySize, color: UIColor.whiteColor(), imageName: nil, backImageName: "goumai", backColor: nil)
        bgView.addSubview(btnMoney)
        btnMoney.snp_makeConstraints { (make) in
            make.bottom.left.right.equalTo(bgView)
            make.height.equalTo(SCREEN_SCALE_HEIGHT * 70)
        }
        
        name = UILabel(ch_text: "作者  \(author)", fontSize: nameSize, color: UIColor.grayColor(), alignment: .Left)
        bgView.addSubview(name)
        name.snp_makeConstraints { (make) in
            make.top.equalTo(lblTitle.snp_bottom).offset(SCREEN_SCALE_HEIGHT * 10)
            make.left.equalTo(lblTitle)
            make.right.equalToSuperview().offset(SCREEN_SCALE_WIDTH * -30)
        }
        
        shoppingCar = UIButton(ch_title: "阅读", fontSize: 14, color: UIColor.whiteColor(), imageName: nil, backImageName: nil, backColor: kCoverColor)
        bgView.addSubview(shoppingCar)
        shoppingCar.layer.cornerRadius = 3
        shoppingCar.snp_makeConstraints { (make) in
            make.centerY.equalTo(imgView.snp_bottom)
            make.left.equalTo(name)
            make.width.equalTo(SCREEN_SCALE_WIDTH * 100)
            make.height.equalTo(SCREEN_SCALE_HEIGHT * 50)
        }
        
        books = UIButton(ch_title: "已加入书架", fontSize: 14, color: UIColor.whiteColor(), imageName: nil, backImageName: nil, backColor: kSHUJIAColor)
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
        jianJie.font = UIFont.systemFontOfSize(titleSize)
        bgView.addSubview(jianJie)
        jianJie.snp_makeConstraints { (make) in
            make.top.equalTo(imgView.snp_bottom).offset(SCREEN_SCALE_HEIGHT * 20)
            make.left.equalTo(imgView)
        }
        
        jianJieContent = UILabel(ch_text: description, fontSize: 14, color: UIColor.colorWithString("#ababab"), alignment: .Justified)
        bgView.addSubview(jianJieContent)
        jianJieContent.snp_makeConstraints { (make) in
            make.top.equalTo(jianJie.snp_bottom).offset(SCREEN_SCALE_HEIGHT * 10)
            make.left.equalTo(jianJie)
            make.right.equalTo(books)
            make.height.equalTo(SCREEN_SCALE_HEIGHT * 440)
        }
        
        imgFileSize = UIImageView(image: UIImage(named: ""), highlightedImage: nil)
        bgView.addSubview(imgFileSize)
        imgFileSize.snp_makeConstraints { (make) in
            make.bottom.equalTo(shoppingCar.snp_top).offset(SCREEN_SCALE_HEIGHT * 20)
            make.left.equalTo(shoppingCar)
            make.height.equalTo(name)
            make.width.equalTo(name.snp_height)
        }
        
    }
    
    //    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    //        self.removeFromSuperview()
    //    }
    
}

