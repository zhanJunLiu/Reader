//
//  UIButton+Extension.swift
//  art-teacher
//
//  Created by 路政浩 on 16/8/11.
//  Copyright © 2016年 com.etudetime. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    
    /// 创建 UIButton
    ///
    /// - parameter title:         title
    /// - parameter fontSize:      fontSize，默认 17
    /// - parameter color:         color，默认 darkGrayColor
    /// - parameter imageName:     imageName，默认 nil
    /// - parameter backImageName: backImageName，默认 nil
    ///
    /// - returns: UIButton
    convenience init(ch_title title: String?,
                              fontSize: CGFloat = 17,
                              color: UIColor = UIColor.darkGrayColor(),
                              imageName: String? = nil,
                              backImageName: String? = nil, backColor: UIColor?) {
        
        self.init()
        
        self.setTitle(title, forState: .Normal)
        self.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        self.setTitleColor(color, forState: .Normal)
        
        if let imageName = imageName {
            self.setImage(UIImage(named: imageName), forState: .Normal)
            self.setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        }
        
        if let backImageName = backImageName {
            self.setBackgroundImage(UIImage(named: backImageName), forState: .Normal)
            self.setBackgroundImage(UIImage(named: backImageName + "_highlighted"), forState: .Highlighted)
        }
        
        if let backColor = backColor {
            self.backgroundColor = backColor
        }
        
        
        sizeToFit()
    }
    
    /**
     
     按钮
     - author: 路政浩
     - date: 16-08-11 20:08:46
     
     - parameter title:					按钮默认状态title
     - parameter fontSize:			    按钮字体大小:默认 15
     - parameter color:					按钮字体颜色:默认 灰色
     - parameter imageName:			    按钮图片:   默认 nil
     - parameter backImageName:	        按钮高亮背景图:  默认 nil
     */
    
    public func mt_setTitle(Title title: String? = nil,
                              fontSize: CGFloat = 15,
                              color: UIColor = UIColor.darkGrayColor(),
                              imageName: String? = nil,
                              backImageName: String? = nil) {
        
        
        self.setTitle(title, forState: .Normal)
        self.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        self.setTitleColor(color, forState: .Normal)
        
        if let imageName = imageName {
            self.setImage(UIImage(named: imageName + "_normal"), forState: .Normal)
            self.setImage(UIImage(named: imageName + "_highlight"), forState: .Highlighted)
        }
        
        if let backImageName = backImageName {
            self.setBackgroundImage(UIImage(named: backImageName + "_normal"), forState: .Normal)
            self.setBackgroundImage(UIImage(named: backImageName + "_highlight"), forState: .Highlighted)
        }
        
        sizeToFit()
    }
    
    public func mt_setTopBtn(Title title: String? = nil,
                                  fontSize: CGFloat = 15,
                                  norColor: UIColor? = nil,
                                  selColor: UIColor? = nil,
                                  backImageName: String? = nil) {
        
        
        self.setTitle(title, forState: .Normal)
        self.setTitle(title, forState: .Selected)
        
        self.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        
        self.setTitleColor(norColor, forState: .Normal)
        self.setTitleColor(selColor, forState: .Selected)
        
        if let backImageName = backImageName {
            self.setBackgroundImage(UIImage(named: backImageName + "_normal"), forState: .Normal)
            self.setBackgroundImage(UIImage(named: backImageName + "_selected"), forState: .Selected)
        }
        
        sizeToFit()
    }
    
    /**
     设置按钮中title的文字和颜色
     
     - parameter titleStr:   默认title字符串
     - parameter titleColor: 默认字体颜色
     */
//    public func setNorTitle(titleStr titleStr:String ,titleColor:UIColor,seleColor:UIColor = kClearColor,endColor:UIColor = kClearColor){
//        
//        setTitle(titleStr, forState: .Normal)
//        
//        setTitleColor(titleColor, forState: .Normal)
//        
//        if seleColor != kClearColor{
//            setTitleColor(seleColor, forState: .Selected)
//        }
//        
//        if endColor != kClearColor{
//            setTitleColor(endColor, forState: .Disabled)
//        }
//    }
    
    /**
     给按钮设置背景图片的方法
     
     - parameter norImage:  普通状态下图片(必填)
     - parameter HigImage:  高亮状态(选填)
     - parameter seleImage: 选中状态(选填)
     - parameter disImage:  禁止状态(选填)
     */
    public func setButtonImage(norImage norImage:String = "",HigImage:String = "",seleImage:String = "",disImage:String = ""){
        
        if norImage.characters.count > 0{
            self.setBackgroundImage(UIImage(named: norImage), forState: .Normal)
        }
        
        if HigImage.characters.count > 0 {
            self.setBackgroundImage(UIImage(named: HigImage), forState: .Highlighted)
        }
        
        if seleImage.characters.count > 0 {
            self.setBackgroundImage(UIImage(named: seleImage), forState: .Selected)
        }
        
        if disImage.characters.count > 0 {
            self.setBackgroundImage(UIImage(named: disImage), forState: .Disabled)
        }
    }
    
    
}