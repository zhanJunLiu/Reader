//
//  DDCollectModel.swift
//  CHReadingBook
//
//  Created by zhuzi on 2016/10/26.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class DDCollectModel: NSObject {

    var user_id:            String!//用户id
    var book_id:            String!//图书id
    var committee_id:       String!//委员id
    var committee_ren_id:   String!//委员人id
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    class func loadCollectData(userid: String, bookid:String, committeeid:String, committeerenid:String, finished: ((result: [DDCollectModel]?) -> ())) {
        
        var models = [DDCollectModel]()
        
        /// 注意泛型, 因为这是swift3中强制的语法
        let parameters:[String : AnyObject] = ["user_id":userid,
                                               "book_id":bookid,
                                               "committee_id":committeeid,
                                               "committee_ren_id":committeerenid
                                                ]
        
        CHNetworkTools.sharedNetworkTool.post(ADD_OR_CANCEL_COLLECTION, parameters: parameters) { (success, result, error) in
            
            print(userid)
            
            guard let result = result where result["status"] == "success" else {
                finished(result: nil)
                return
            }
            
            print("result: \(result)")
            print("error: \(error)")
            let data = result["list"].arrayObject as? [[String : AnyObject]]
            
            if data == nil {
                finished(result: nil)
                return
            }else {
                
                for dict in data! {
                    
                    models.append(DDCollectModel(dict: dict))
                }
                finished(result: models)
            }
            
            return
        }
        
    }

}
