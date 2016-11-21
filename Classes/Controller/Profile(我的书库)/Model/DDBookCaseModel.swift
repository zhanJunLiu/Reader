//
//  DDBookCaseModel.swift
//  CHReadingBook
//
//  Created by zhuzi on 2016/11/9.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class DDBookCaseModel: NSObject {

    var user_id:                String!//用户id
    var user_name:              String!//用户名字
    var book_id:                String!//图书id
    var book_name:              String!//图书名字
    var book_pic:               String!//图书封面
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    class func loadCollectData(userid: String, finished: ((result: [DDBookCaseModel]?) -> ())) {
        
        var models = [DDBookCaseModel]()
        
        
        /// 注意泛型, 因为这是swift3中强制的语法
        let parameters:[String : AnyObject] = ["user_id": userid]
        
        CHNetworkTools.sharedNetworkTool.post(MYBOOKCASE, parameters: parameters) { (success, result, error) in
            
            print(userid)
            
            guard let result = result where result["status"] == "success" else {
                finished(result: nil)
                return
            }
            
            print("result: \(result)")
            let data = result["list"].arrayObject as? [[String : AnyObject]]
            
            if data == nil {
                finished(result: nil)
                return
            }else {
                
                for dict in data! {
                    
                    models.append(DDBookCaseModel(dict: dict))
                }
                finished(result: models)
            }
            
            return
        }
        
    }

}
