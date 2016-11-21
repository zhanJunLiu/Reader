//
//  ZJAccountModel.swift
//  CHReadingBook
//
//  Created by mac on 16/9/19.
//  Copyright © 2016年 mac. All rights reserved.
//

var userID: Int? = 16


import UIKit

class ZJAccountModel: NSObject {
    
    // MARK: - 属性
    /// 令牌
    var token:      String?
    
    /// token过期时间
    var expiryTime: String?
    
    /// 用户id
    var user_id:    Int = 0
    
    /// 用户成功或者失败的结果
    var result:     String?
    
    /// 昵称
    var nickname:   String?
    
    /// 头像
    var avatar:     String?
    
    /// 电话号码
    var tel:     String?
    
    /// 性别
    var sex:        Int = 0
    
    /// qq登录
    var qqBinding:  Int = 0
    
    /// 微信qq登录
    var weixinBinding: Int = 0
    
    /// 微博登录
    var weiboBinding:Int = 0
    
    /// 注册时间
    var registerTime: String?
    
    /// 微信用户头像
    var headimgurl:  String?
    
    // MARK: - 转模型
    /// KVC 字典转模型
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    // MARK: - 外部调用接口
    /** 
     获取用户对象 (这不是单例, 只是对象静态化了)
     */
    static func shareAccount() -> ZJAccountModel? {
        
        if userAccount == nil {
            userAccount =  NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? ZJAccountModel
            return userAccount
        }else {
            return userAccount
        }
    }
    
    /**
     是否已经登录
     */
    class func isLogin() -> Bool {
        return ZJAccountModel.shareAccount() != nil
    }

    /**
     注销清理
     */
    class func logout() {
        
        // 取消第三方登录授权
//        ShareSDK.cancelAuthorize(SSDKPlatformType.TypeQQ)
//        ShareSDK.cancelAuthorize(SSDKPlatformType.TypeSinaWeibo)
    
        // 清除内存中的账户数据和归档中的数据
        ZJAccountModel.userAccount = nil
        do {
            try NSFileManager.defaultManager().removeItemAtPath(ZJAccountModel.accountPath)
        } catch {
            //            print("退出异常")
        }
    }
    
    /**
     检查token有效期
     */
    class func checkToken() {
        if ZJAccountModel.isLogin() {
            guard let expiryTime = ZJAccountModel.shareAccount()?.expiryTime else {
                return
            }
            
            // 获取当前时间的时间戳
            let nowTime = NSDate().timeIntervalSince1970
            if nowTime > NSTimeInterval(expiryTime) {
                ZJAccountModel.logout()
            }
        }
    }
    // MARK: - 内部处理方法
    /**
     登录保存用户信息
     */
    func saveUserInfo() {
        // 保存到内存中
        ZJAccountModel.userAccount = self
        // 归档用户信息
        saveAccount()
    }

    // 持久保存到内存中
    private static var userAccount: ZJAccountModel?

    /// 归档账号的路径
    static let accountPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! + "/Account.plist"
    
    /**
     归档用户数据
     */
    private func saveAccount() {
        NSKeyedArchiver.archiveRootObject(self, toFile: ZJAccountModel.accountPath)
    }
    // MARK: - 归档和解档
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(token, forKey: "token_key")
        aCoder.encodeObject(expiryTime, forKey: "expiry_time_key")
        aCoder.encodeInt(Int32(user_id), forKey: "id_key")
        aCoder.encodeObject(nickname, forKey: "nickname_key")
        aCoder.encodeObject(avatar, forKey: "avatar_key")
        aCoder.encodeObject(tel, forKey: "tel_key")
        aCoder.encodeInt(Int32(sex), forKey: "sex_key")
        aCoder.encodeInt(Int32(qqBinding), forKey: "qq_binding_key")
        aCoder.encodeInt(Int32(weixinBinding), forKey: "weixin_binding_key")
        aCoder.encodeInt(Int32(weiboBinding), forKey: "weibo_binding_key")
        aCoder.encodeObject(registerTime, forKey: "register_time_key")
    }
    required init?(coder aDecoder: NSCoder) {
        token = aDecoder.decodeObjectForKey("token_key") as? String
        expiryTime = aDecoder.decodeObjectForKey("expiry_time_key") as? String
        user_id = Int(aDecoder.decodeIntForKey("id_key"))
        nickname = aDecoder.decodeObjectForKey("nickname_key") as? String
        avatar = aDecoder.decodeObjectForKey("avatar_key") as? String
        tel = aDecoder.decodeObjectForKey("tel_key") as? String
        sex = Int(aDecoder.decodeIntForKey("sex_key"))
        qqBinding = Int(aDecoder.decodeIntForKey("qq_binding_key"))
        weixinBinding = Int(aDecoder.decodeIntForKey("weixin_binding_key"))
        weiboBinding = Int(aDecoder.decodeIntForKey("weibo_binding_key"))
        registerTime = aDecoder.decodeObjectForKey("register_time_key") as? String
    }
}

// MARK: - 各种网络请求
extension ZJAccountModel {
    
    /**
     修改用户密码
     
     - parameter credentialOld: 旧密码
     - parameter credentialNew: 新密码
     - parameter finished:      完成回调
     */
    class func modifyPassword(credentialOld: String, credentialNew: String, finished: (success: Bool, tip: String) -> ()) {
        
        let parameters: [String : AnyObject] = [
            "user_id" : ZJAccountModel.shareAccount()!.user_id,
            "credential_old" : credentialOld,
            "credential_new" : credentialNew
        ]
        
        CHNetworkTools.sharedNetworkTool.post("", parameters: parameters) { (success, result, error) in
            
            guard let result = result else {
                finished(success: false, tip: "您的网络不给力哦")
                return
            }
            
            if result["status"] == "success" {
                finished(success: true, tip: "修改密码成功")
            } else {
                finished(success: false, tip: result["status"].stringValue)
            }
        }
    }
    /**
     普通账号注册
     
     - parameter type:     注册类型
     - parameter username: 用户名/邮箱/手机号码等
     - parameter password: 密码
     - parameter finished: 完成回调
     */
    class func normalAccountRegister(type: String, username: String, password: String, finished: (success: Bool, tip: String) -> ()) {
        
        let parameters: [String : AnyObject] = [
            "tel" : username,
            "password" : password,
            "type" : type
        ]
        
        CHNetworkTools.sharedNetworkTool.post(REGISTER, parameters: parameters) { (success, result, error) in
            
            guard let result = result else {
                finished(success: false, tip: "您的网络不给力哦")
                return
            }
            
            if result["status"] == "success" {
                finished(success: true, tip: "注册成功")
            } else {
                finished(success: false, tip: result["status"].stringValue)
            }
        }
    }
    /**
     普通账号登录
     
     - parameter type:     登录类型
     - parameter username: 用户名/邮箱/手机号码
     - parameter password: 密码
     - parameter finished: 完成回调
     */
    class func normalAccountLogin(type: String, username: String, password: String, finished: (success: Bool, tip: String) -> ()) {
        
        let parameters: [String : AnyObject] = [
            "tel" : username,
            "password" : password,
            "type" : type
        ]
        
        CHNetworkTools.sharedNetworkTool.post(LOGIN, parameters: parameters) { (success, result, error) in
            
            guard let result = result else {
                finished(success: false, tip: "您的网络不给力哦")
                return
            }
            
            print(result)
            
            if result["status"] == "success" {
                
                let data = result["list"].arrayObject as! [[String : AnyObject]]
                
                let dict = data[0] as Dictionary

                if dict["result"] as? String == "ok" {
                    print("查看字典: \(dict)")
                    let account = ZJAccountModel(dict: dict)
                    
                    userID = account.user_id
                    
                    account.saveUserInfo()
                    finished(success: true, tip: "登录成功")
                } else if dict["result"] as? String == "off" {
                    CHProgressHUD.showErrorWithStatus("号码不存在")
                }else if dict["result"] as? String == "false"  {
                    CHProgressHUD.showErrorWithStatus("账号或密码不正确")
                }
            }else {
                finished(success: false, tip: result["status"].stringValue)
            }
        }
    }

    /**
     第三方登录
     
     - parameter type:     类型 qq weibo
     - parameter openid:   uid
     - parameter token:    token
     - parameter nickname: 昵称
     - parameter avatar:   头像
     - parameter sex:      性别 0:女 1:男
     - parameter finished: 完成回调
     */
    class func thirdAccountLogin(type: String, openid: String, token: String, nickname: String, avatar: String, sex: Int, finished: (success: Bool, tip: String) -> ()) {
        
        let parameters: [String : AnyObject] = [
            "type" : type,
            "user_id" : openid,
            "token" : token,
            "nickname" : nickname,
            "avatar" : avatar,
            "sex" : sex
        ]
        
        CHNetworkTools.sharedNetworkTool.post(THIRD_LOGIN, parameters: parameters) { (success, result, error) in
            
            guard let result = result else {
                finished(success: false, tip: "您的网络不给力哦")
                return
            }
            
            print("服务器返回结果: \(result)")
            
            if result["status"] == "success" {
                
                let data = result["list"].arrayObject as! [[String : AnyObject]]
                
                for dict in data {
                    let account = ZJAccountModel(dict: dict)
                    
                    print("第三方登录成功回调结果: \(dict)")
                    
                    account.saveUserInfo()
                }
                
                finished(success: true, tip: "登录成功")
            } else {
                finished(success: false, tip: result["status"].stringValue)
            }
        }
    }
    
    /**
     上传用户头像
     
     - parameter userId:      用户id
     - parameter avatarImage: 头像图片对象
     */
    class func uploadUserAvatar(avatarImage: UIImage, finished: (success: Bool) -> ()) {
        
        let imageData = UIImageJPEGRepresentation(avatarImage, 1)!
        let imageBase64 = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue:0))
        
        let parameters: [String : AnyObject] = [
            "user_id" : ZJAccountModel.shareAccount()!.user_id,
            "photo" : imageBase64
        ]
        
        CHNetworkTools.sharedNetworkTool.post(UPLOAD_USER_AVATAR, parameters: parameters) { (success, result, error) in
            
            guard let result = result where result["status"] == "success" else {
                finished(success: false)
                return
            }
            
            finished(success: true)
        }
    }
    
    /**
     修改更新用户信息
     
     - parameter nickname: 昵称
     - parameter sex:      性别 0女 1男
     - parameter say:      个性签名
     - parameter finished: 完成回调
     */
    class func updateUserInfo(nickname: String, sex: String, age: Int, finished: (success: Bool) -> ()) {
        
        let parameters: [String : AnyObject] = [
            "user_id" : ZJAccountModel.shareAccount()!.user_id,
            "nickname" : nickname,
            "sex" : sex,
            "age" : age
        ]
        
        CHNetworkTools.sharedNetworkTool.post(UPDATE_USER_INFOMATION, parameters: parameters) { (success, result, error) in
            
            print("发送成功")
            print("result: \(result)")
            guard let result = result where result["status"] == "success" else {
                finished(success: false)
                return
            }
            
            finished(success: true)
        }
    }
    
    /**
     获取自己的用户信息 - 获取成功会更新本地用户信息
     
     - parameter finished: 完成回调
     */
    class func getSelfUserInfo(finished: (success: Bool) -> ()) {
        
        if !ZJAccountModel.isLogin() {
            return
        }
        
        let parameters: [String : AnyObject] = [
            "user_id" : ZJAccountModel.shareAccount()!.user_id
        ]
        
        CHNetworkTools.sharedNetworkTool.post(GET_SELF_USER_INFOMATION, parameters: parameters) { (success, result, error) in
            
            print("发送成功")
            print("result: \(result)")
            guard let result = result where result["status"] == "success" else {
                finished(success: false)
                return
            }
            
            // 更新用户信息而不更新token
            //            let account = ZJAccountModel(dict: result["result"].dictionaryObject!)
            let data = result["list"].arrayObject as? [[String : AnyObject]]
            var account : ZJAccountModel?
            for dict in data! {
                account = ZJAccountModel(dict: dict)
            }
            account!.token = ZJAccountModel.shareAccount()?.token
            account!.saveUserInfo()
            
            finished(success: true)
            
        }
    }
    
    /**
     获取他人的用户信息 - 获取成功返回给调用者
     
     - parameter finished: 完成回调
     */
    class func getOtherUserInfo(otherUserId: Int, finished: (userInfo: ZJAccountModel?) -> ()) {
        
        if !ZJAccountModel.isLogin() {
            return
        }
        
        let parameters: [String : AnyObject] = [
            "user_id" : ZJAccountModel.shareAccount()?.user_id ?? 0,
            "other_user_id" : otherUserId
        ]
        
        CHNetworkTools.sharedNetworkTool.get(GET_OTHER_USER_INFOMATION, parameters: parameters) { (success, result, error) in
            
            guard let result = result where result["status"] == "success" else {
                finished(userInfo: nil)
                return
            }
            
            let userInfo = ZJAccountModel(dict: result["result"].dictionaryObject!)
            finished(userInfo: userInfo)
        }
    }
}
