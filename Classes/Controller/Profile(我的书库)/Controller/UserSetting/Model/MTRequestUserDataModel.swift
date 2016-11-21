//
//  MTRequestUserDataModel.swift
//  art-teacher
//
//  Created by 路政浩 on 16/8/8.
//  Copyright © 2016年 com.etudetime. All rights reserved.
//
import UIKit

/** 昵称key*/
private let nikeName_Key       = "nikeName"
/** 性别key*/
private let gender_Key         = "gender"
/** 年龄key*/
private let age_Key            = "age"

/** 积分key*/
private let account_Key        = "account"

/** 理想学校key*/
private let dreamSchool_Key    = "dreamSchool"
/** 理想专业key*/
private let dreamMajor_Key     = "dreamMajor"
/** 原图头像key*/
private let originalUrl_Key    = "imgOriginalUrl"
/** 压缩头像key*/
private let compressUrl_Key    = "imgCompressUrl"

/** 签名key*/
private let signature_Key      = "signature"


class MTRequestUserDataModel: NSObject{
    
    /** 偏好设置对象*/
    private var defaults = NSUserDefaults.standardUserDefaults()

    /** 昵称 */
    var nikeName: String = "请登录"
    
    
    /** 年龄*/
    var age: Int = 0
    
    /** 性别-String*/
    var gender: Int = 0
//    var gender: String = ""
    
    /** 积分*/
    var account: Int = 0
    
    
    /** 理想学校*/
    var dreamSchool: String = ""
    
    /** 理想专业*/
    var dreamMajor: String = ""
    
    /** 头像- 原图*/
    var imgOriginalUrl: String = ""
    
    /** 头像-压缩图*/
    var imgCompressUrl: String = ""
    
    
    /** 签名*/
    var signature: String = ""
    
    func get() -> MTRequestUserDataModel? {
        var cacheData = defaults.objectForKey("user")
        cacheData = cacheData as? Dictionary<String,AnyObject>
        if cacheData != nil {
            return MTRequestUserDataModel.yy_modelWithJSON(cacheData!)
        }
        return nil
    }
    
    func set(dic:[String:AnyObject]) {
        defaults.setValue(dic, forKey: "user")
    }
    
    func remove() {
        defaults.removeObjectForKey("user")
    }
}
