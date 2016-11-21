//
//  DDMessageModel.swift
//  CHReadingBook
//
//  Created by zhuzi on 16/10/9.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class DDMessageModel: NSObject {
    
    var activity_pic:       String!//活动页
    var activity_title:     String!//活动标题
    var activity_time:      String!//活动时间
    var activity_time2:     String!//活动时间
    var activity_time3:     String!//活动时间
    var activity_time4:     String!//活动时间
    var activity_address:   String!//活动地址
    var activity_id:        String!//活动id
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    class func loadMessageData(finished: ((result: [DDMessageModel]?) -> ())) {
        
        var models = [DDMessageModel]()
        
        CHNetworkTools.sharedNetworkTool.get(ACTIVITY_URL, parameters: nil) { (success, result, error) in
            
            guard let result = result where result["status"] == "success" else {
                return
            }
            
            let data = result["list"].arrayObject as? [[String: AnyObject]]
            print(data)
            for dict in data! {
                models.append(DDMessageModel(dict: dict))
            }
            
            finished(result: models)
        }
        
    }
    
}
