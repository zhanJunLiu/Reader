//
//  WeChat.swift
//  CHReadingBook
//
//  Created by mac on 16/9/23.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

/** 第三方程序要向微信申请认证，并请求某些权限，需要调用WXApi的sendReq成员函数，向微信终端发送一个SendAuthReq消息结构。微信终端处理完后会向第三方程序发送一个处理结果。
 * @see SendAuthResp
 * @note scope字符串长度不能超过1K
 */
let weChatScope = "snsapi_userinfo"

/** 第三方程序本身用来标识其请求的唯一性，最后跳转回第三方程序时，由微信终端回传。
 * @note state字符串长度不能超过1K
 */
let weChatState = "123"

class WeChat: NSObject {
    
    /** 微信登录 */
    class func weChatLogin() {
    
        let req = SendAuthReq()
        req.scope = weChatScope
        req.state = weChatState
        WXApi.sendReq(req)
    }
    
    /**
     微信支付
     */
    class func weChatPay(payParams:[String:AnyObject]){
        let request = PayReq()
        request.openID    = payParams["appid"] as! String
        request.partnerId = payParams["partnerid"] as! String //商户号
        request.prepayId  = payParams["prepayid"] as! String  //预支付交易会话ID
        request.package   = payParams["package"] as! String   //扩展字段
        request.nonceStr  = payParams["noncestr"] as! String
        request.timeStamp = UInt32(payParams["timestamp"] as! String)!
        request.sign      = payParams["sign"] as! String
        WXApi.sendReq(request)
    }
    
    /**
     微信支付是否成功
     */
    class func weChatPayIsOk(resp: BaseResp!){
        let response = resp as! PayResp
        switch  response.errCode{
        case WXSuccess.rawValue:
            //通知支付页面微信支付完成
            NSNotificationCenter.defaultCenter().postNotificationName(kThirdPayNotification, object: self, userInfo: nil)
            break
        default:
            break
        }
    }
    
    /**
     微信登录是否成功
     */
    class func weChatLoginIsOk(resp: BaseResp!){
        
        let response = resp as! SendAuthResp
        //判断微信返回来的错误码是否是登录成功
        switch  WeixinErrCode(rawValue: response.errCode)!{
            
        case .Ok:
            
            print(response.code)
            CHNetworkTools.sharedNetworkTool.loadWeixinToken(response.code, finished: { (success, error) in
                if error != nil {
                    return
                }
                NSNotificationCenter.defaultCenter().postNotificationName(kWeChatLoginNotification, object: self, userInfo: nil)
            })
            print("成功")
            break
            case .UserCancel:
            print("取消")
            break
            case .UserDenied:
            print("拒绝")
            break
            default:
            break
        }
    }
}
