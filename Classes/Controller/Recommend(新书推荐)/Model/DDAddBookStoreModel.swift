//
//  DDAddBookStoreModel.swift
//  CHReadingBook
//
//  Created by zhuzi on 2016/10/28.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class DDAddBookStoreModel: NSObject {
    
    var user_id:            String!//用户id
    var book_id:            String!//图书id
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    class func loadAddBookStoreData(userid: String, bookid: String, finished: ((result: [DDAddBookStoreModel]?) -> ())) {
        
        var models = [DDAddBookStoreModel]()
        
        /// 注意泛型, 因为这是swift3中强制的语法
        let parameters:[String : AnyObject] = ["user_id":userid,
                                               "book_id":bookid
        ]
        
        CHNetworkTools.sharedNetworkTool.post(ADD_BOOKSTORE, parameters: parameters) { (success, result, error) in
            
            print(userid)
            
            guard let result = result where result["status"] == "success" else {
                finished(result: nil)
                return
            }
            
            print("result: \(result)")
            print("error: \(error)")
//            let data = result["list"].arrayObject as? [[String : AnyObject]]
            let data = result["result"]
            
            if data == "0" {
                finished(result: nil)
                return
            }
//            else {
//
//                for dict in data! {
//                    
//                    models.append(DDAddBookStoreModel(dict: dict))
//                }
//                finished(result: models)
//            }
            
            return
        }
        
    }


}
