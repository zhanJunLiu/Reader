//
//  CHAliPay.swift
//  CHReadingBook
//
//  Created by mac on 2016/10/10.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

/**
 let payParamses = "app_id=2016081601753857&biz_content=%7B%22timeout_express%22%3A%2230m%22%2C%22seller_id%22%3A%22wenshicaiwu%40sina.com%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22total_amount%22%3A%220.1%22%2C%22subject%22%3A%221%22%2C%22body%22%3A%22%E6%B0%B4%E6%B5%92%E4%BC%A0%22%2C%22out_trade_no%22%3A%22TSX147865949516%22%7D&charset=utf-8&format=json&method=alipay.trade.app.pay&notify_url=http%3A%2F%2F192.168.31.47%2Falipay.php%2FNotifyurl&sign_type=RSA&timestamp=2016-11-09+10%3A44%3A55&version=1.0&sign=dH59x0wl0fNX4WpKiKrwpycjvrwJvhb5d7lQ%2BYYOkqbpkLn2LsMdhblWOrb5y9%2FeS0w%2BaPJiqq4rC%2Bj43%2BHpjGlaU2%2FFhIOsle0m8v0aKUcfO3U2AwWF1jme4QkGhhd9LsujIG%2FsVkjPle68ac3jbzkLVSk4Kl5XPMSE6oCHEbc%3D"
 
 //        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types一致
 let appScheme = "AlipayProject"; //需要和URL Types统一
 
 AlipaySDK.defaultService().payOrder(payParamses, fromScheme: appScheme) { (dict) in
 self.zhifubaoPayCallBack(dict)
 }
 */

//class CHAliPay: NSObject {
//    
//    // 支付宝支付
//    class func aliPay(dict: [String: AnyObject]) {
//        
//        print("服务端返回数据： \(dict)")
//        
//        let appScheme = "AlipayProject"; //需要和URL Types统一
//        
//        let order = Order()
//        order.app_id = dict["app_id"] as? String // PID
//        // NOTE: 支付接口名称
//        order.method = "alipay.trade.app.pay"
//        // NOTE: 参数编码格式
//        order.charset = "utf-8"
//        let now = NSDate()
//        let dformatter = NSDateFormatter()
//        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
//        order.timestamp = dformatter.stringFromDate(now)
//        
//        order.return_url = dict["notify_url"] as? String
//        // NOTE: 支付版本
//        order.version = "1.0"
//        
//        // NOTE: sign_type设置
//        order.sign_type = "RSA";
//        
//        // NOTE: 商品数据
//        order.biz_content = BizContent()
//        order.biz_content.seller_id = dict["seller_id"] as? String // 支付宝收款账号.手机号.邮箱
//        order.biz_content.body = dict["body"] as? String // 书名
//        order.biz_content.subject = dict["subject"] as? String;
//        order.biz_content.out_trade_no = dict["out_trade_no"] as? String //订单ID（由商家自行制定）
//        order.biz_content.timeout_express = dict["it_b_pay"] as? String; //超时时间设置
//        order.biz_content.total_amount = dict["total_fee"] as? String //商品价格
//        
//        
//        
//        //将商品信息拼接成字符串生成订单描述
//        let orderSpec = order.description
//        let signedString = dict["private_key"] as? String
//        let orderString = "\(orderSpec)&sign=\(signedString)&sign_type=RSA"
//        AlipaySDK.defaultService().payOrder(orderString, fromScheme: appScheme) { (dict) in
//            
//            self.zhifubaoPayCallBack(dict)
//        }
//    }
//    
//    //支付宝支付的回调
//    class func zhifubaoPayCallBack(resultDic:[NSObject : AnyObject]){
//        
//        if let Alipayjson:[String:AnyObject] = resultDic as? [String:AnyObject]{
//            let resultStatus = Alipayjson["resultStatus"] as! String
//            if resultStatus == "9000"{
//                print("订单支付成功 欧巴")
//                NSNotificationCenter.defaultCenter().postNotificationName(kThirdNotification, object: self, userInfo: nil)
//            }else if resultStatus == "8000" {
//                print("正在处理中")
//            }else if resultStatus == "4000" {
//                print("订单支付失败")
//            }else if resultStatus == "6001" {
//                print("用户中途取消")
//            }else if resultStatus == "6002" {
//                print("网络连接出错")
//            }
//        }
//    }
//}


class CHAliPay: NSObject {
    
    // 支付宝支付
    class func aliPay(payParams: String) {
        
        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types一致
        let appScheme = "AlipayProject"; //需要和URL Types统一
        
        AlipaySDK.defaultService().payOrder(payParams, fromScheme: appScheme) { (dict) in
            
            self.zhifubaoPayCallBack(dict)
        }
    }
    
    //支付宝支付的回调
    class func zhifubaoPayCallBack(resultDic:[NSObject : AnyObject]){
        
        if let Alipayjson:[String:AnyObject] = resultDic as? [String:AnyObject]{
            let resultStatus = Alipayjson["resultStatus"] as! String
            if resultStatus == "9000"{
                print("订单支付成功")
                NSNotificationCenter.defaultCenter().postNotificationName(kThirdNotification, object: self, userInfo: nil)
                let parameters: [String : AnyObject] = ["resultDict": Alipayjson["result"]!, "resultStatus":resultStatus]
                CHNetworkTools.sharedNetworkTool.post(ALIPAYISPAYOK, parameters: parameters) { (success, result, error) in
                    
                }
            }else if resultStatus == "8000" {
                print("正在处理中")
            }else if resultStatus == "4000" {
                print("订单支付失败")
                
            }else if resultStatus == "6001" {
                print("用户中途取消")
            }else if resultStatus == "6002" {
                print("网络连接出错")
            }
        }
    }
}
