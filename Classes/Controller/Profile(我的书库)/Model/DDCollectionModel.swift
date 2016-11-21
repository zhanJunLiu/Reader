//
//  DDCollectionModel.swift
//  CHReadingBook
//
//  Created by zhuzi on 2016/10/16.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class DDCollectionModel: NSObject {
    
    var user_id:                String!//用户id
    var user_name:              String!//用户名字
    var is_collect:             String!//是否收藏
    var book_id:                String!//图书id
    var book_name:              String!//图书名字
    var book_pic:               String!//图书封面
    var committee_ren_id:       String!//委员id
    var committee_ren_name:     String!//委员名字
    var committee_ren_head:     String!//委员头像
    var committee_book_title:   String!//委员书标题
    var committee_book_details: String!//委员书描述
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    class func loadCollectData(userid: String, finished: ((result: [DDCollectionModel]?) -> ())) {
        
        var models = [DDCollectionModel]()
        
//        CHNetworkTools.sharedNetworkTool.get(GET_COLLECTION_LIST, parameters: nil) { (success, result, error) in
//            
//            guard let result = result where result["status"] == "success" else {
//                return
//            }
//            
//            let data = result["list"].arrayObject as? [[String: AnyObject]]
//            print(data)
//            for dict in data! {
//                models.append(DDCollectionModel(dict: dict))
//            }
//            
//            finished(result: models)
//        }
        
        /// 注意泛型, 因为这是swift3中强制的语法
        let parameters:[String : AnyObject] = ["user_id": userid]
        
        CHNetworkTools.sharedNetworkTool.post(GET_COLLECTION_LIST, parameters: parameters) { (success, result, error) in
            
//            print(userid)
            
            guard let result = result where result["status"] == "success" else {
                finished(result: nil)
                return
            }
            
//            print("result: \(result)")
            let data = result["list"].arrayObject as? [[String : AnyObject]]
            
            if data == nil {
                finished(result: nil)
                return
            }else {
                
                for dict in data! {
                    
                    models.append(DDCollectionModel(dict: dict))
                }
                finished(result: models)
            }
            
            return
        }

    }

}
