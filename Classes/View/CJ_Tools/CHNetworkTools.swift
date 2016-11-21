//
//  CHNetworkTools.swift
//  TestNetworking
//
//  Created by mac on 16/9/17.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

/// 网络请求回调
typealias NetworkFinished = (success: Bool, result: JSON?, error: NSError?) -> ()

typealias WeChatFinished = (dict: [String:AnyObject]?,error: NSError?) -> ()

class CHNetworkTools: NSObject {
    
    /// 网络工具类单例
    static let sharedNetworkTool = CHNetworkTools()
}

typealias Progress = (((result: Int) -> ()))

// MARK: - 基础请求方法
extension CHNetworkTools {
    
    /**
     GET请求
     
     - parameter APIString:  urlString
     - parameter parameters: 参数
     - parameter finished:   完成回调
     */
    func get(APIString: String, parameters: [String: AnyObject]?, finished: NetworkFinished) {
        
        Alamofire.request(.GET, "\(BASE_URL)\(APIString)", parameters: parameters).responseJSON { (response) -> Void in
            
            if let data = response.data {
                let json = JSON(data: data)
                // print(json)
                finished(success: true, result: json, error: nil)
            } else {
                CHProgressHUD.showInfoWithStatus("您的网络不给力哦")
                finished(success: false, result: nil, error: response.result.error)
            }
        }
    }

    /**
     POST请求
     
     - parameter APIString:  urlString
     - parameter parameters: 参数
     - parameter finished:   完成回调
     */
    func post(APIString: String, parameters: [String : AnyObject]?, finished: NetworkFinished) {
        
        print("\(BASE_URL)\(APIString)")
        Alamofire.request(.POST, "\(BASE_URL)\(APIString)", parameters: parameters).responseJSON { (response) -> Void in
            
            if let data = response.data {
                let json = JSON(data: data)
                // print(json)
                finished(success: true, result: json, error: nil)
            } else {
                CHProgressHUD.showInfoWithStatus("您的网络不给力哦")
                finished(success: false, result: nil, error: response.result.error)
            }
        }
    }
    
    
    /**
     获取微信成功回调信息
     
     - parameter APIString:  后台url
     - parameter parameters: 微信返回的参数
     - parameter finished:   成功的回调
     */
    func loadWeixinPost(APIString: String, parameters: [String : AnyObject]?, openid: String, token: String, finished: WeChatFinished) {
        Alamofire.request(.GET, "\(APIString)", parameters: parameters).responseJSON { (response) -> Void in
            
            if let data = response.data {
                
                let json = JSON(data: data)
                
                let dict = json.dictionaryObject! as [String : AnyObject]
                
                 print(dict)
                
                let nickName = dict["nickname"] as! String
                let avatar = dict["headimgurl"] as! String
                let sex = dict["sex"] as! Int
                
                CHProgressHUD.showWithStatus("正在登录")
                ZJAccountModel.thirdAccountLogin("weixin", openid: openid, token: token, nickname: nickName, avatar: avatar, sex: sex, finished: { (success, tip) in
                    
                    if success {
                        CHProgressHUD.dismiss()
//                        NSUserDefaults.standardUserDefaults().setObject(self.loginView.iPhone.text!, forKey: "")
//                        NSUserDefaults.standardUserDefaults().setObject(self.loginView.password.text!, forKey: "")
//                        self.didClickVisitorButton()
//                        self.navigationController?.popToRootViewControllerAnimated(true)
                        NSNotificationCenter.defaultCenter().postNotificationName(kWeChatLoginOk, object: self, userInfo: nil)
                    } else {
                        CHProgressHUD.showInfoWithStatus(tip)
                    }
                })
                
            } else {
                CHProgressHUD.showInfoWithStatus("您的网络不给力哦")
                finished(dict: nil, error: nil)
            }
        }
    }
    
    /**
     获取微信数据
     
     - parameter code:     编码
     - parameter finished: 成功回调
     */
    func loadWeixinToken(code:String, finished: WeChatFinished){
        
        let urlString = "https://api.weixin.qq.com/sns/oauth2/access_token?"
        let parameter = ["appid": WX_APP_ID,
                         "secret": WX_APP_SECRET,
                         "code": code,
                         "grant_type":"authorization_code"]
        
        func loadWeixinLogin(access_token:String,third_open_id:String,complition:(dict:[String : AnyObject]?,error:NSError?) -> ()){
            
            let parameters = [
                "way":"3",
                "access_token":access_token,
                "third_open_id":third_open_id
            ]
            
            loadWeixinPost("https://api.weixin.qq.com/sns/userinfo?access_token=\(access_token)&openid=\(third_open_id)", parameters: parameters, openid: third_open_id, token: access_token, finished: complition)
        }
 
        Alamofire.request(.GET, urlString, parameters: parameter).responseJSON { (response) -> Void in
            
            if let dict = response.result.value as? [String:AnyObject]{
                loadWeixinLogin(dict["access_token"] as! String, third_open_id: dict["openid"] as! String, complition: finished)
                print("微信获取授权登录:\(dict)")
            }
        }
    }
}
