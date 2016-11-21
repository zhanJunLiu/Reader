//
//  ZJConst.swift
//  Scholar
//
//  Created by mac on 16/9/5.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

let SCREEN_SCALE_WIDTH = (CGRectGetWidth(UIScreen.mainScreen().bounds) / 750.0)
let SCREEN_SCALE_HEIGHT = (CGRectGetHeight(UIScreen.mainScreen().bounds) / 1334.0)

let SCREEN_W = UIScreen.mainScreen().bounds.size.width
let SCREEN_H = UIScreen.mainScreen().bounds.size.height


//px-->pt
let pxSizePt = CGFloat(0.375)

/// 是否登录
let isLogin = "isLogin"

/// 微信登录通知
let kWeChatLoginOk = "WeChatLoginOk"
let kWeChatLoginNotification = "WeChatLoginNotification"
let kThirdPayNotification = "weChatPayOk"

// 支付宝回调结果 是否成功
let kThirdNotification   = "AliPayOk"

// 第三方登录成功的回调
let kThirdLoginKey = "kThirdLoginKeyOK"

/** 统一设置导航栏按钮的大小 */
let barItemSize: CGFloat = 45

/// 间距
let kMargin: CGFloat = 10.0

/// 线宽
let klineWidth: CGFloat = 1.0

/// 按钮的大小
let btnSize: CGFloat = SCREEN_SCALE_WIDTH * 60

/// 头像大小
let headSize: CGFloat = SCREEN_SCALE_WIDTH * 150

/// 我的界面头部图像的高度
let ZJMineHeaderImageHeight: CGFloat = 200

/// 首页顶部标签指示条的高度
let kIndicatorViewH: CGFloat = 2.0

/// 动画时长
let kAnimationDuration = 0.25

/// 主题颜色
let kTopicColor      = UIColor.colorWithString("#2ed0cc")

let kCoverColor      = UIColor.colorWithString("#91a3bd")

let kSHUJIAColor     = UIColor.colorWithString("#415e87")

/** 个人中心头像背景 */
let kUserBgColor     = UIColor.colorWithString("#3f588c")

/** 设置tabBar的背景颜色 */
let kTabBar_bg        = UIColor.colorWithString("#353f4e")

/// RGBA的颜色设置
func ZJColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

/// 背景灰色
func ZJGlobalColor() -> UIColor {
    return ZJColor(240, g: 240, b: 240, a: 1)
}

/// 红色
func ZJGlobalRedColor() -> UIColor {
    return ZJColor(245, g: 80, b: 83, a: 1.0)
}

/// 蓝色
func ZJGlobalBlueColor() -> UIColor {
    return ZJColor(63, g: 86, b: 137, a: 1.0)
}

/// 深蓝色
func ZJGlobalBlackBlueColor() -> UIColor {
    return ZJColor(50, g: 63, b: 76, a: 1.0)
}

/// 白色
func ZJGlobalWitheColor() -> UIColor {
    return ZJColor(1, g: 1, b: 1, a: 1.0)
}

/// 黑色
func ZJGlobalBlackColor() -> UIColor {
    return ZJColor(0, g: 0, b: 0, a: 1.0)
}
