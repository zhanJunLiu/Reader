//
//  CHReadingHeader.swift
//  CHReadingBook
//
//  Created by mac on 16/9/27.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class CHReadingHeader: NSObject {
    
    var book_name:          String?
    
    var book_pic:           String?
    
    var committee_first:    String?
    
    var committee_ren_name: String?
    
    var committee_bgpic:    String?
    
    var book_id:            String?
    
    var committee_id:       String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    class func loadHomeData(finished: ((result: [CHReadingHeader]?) -> ())) {
        
        var models = [CHReadingHeader]()
        
        CHNetworkTools.sharedNetworkTool.get(READING_H_URL, parameters: nil) { (success, result, error) in
            
            guard let result = result where result["status"] == "success" else {
                finished(result: nil)
                return
            }
            
            let data = result["list"].arrayObject as! [[String : AnyObject]]
                        
            for dict in data {
                
                models.append(CHReadingHeader(dict: dict))
            }
            
            finished(result: models)
            return
        }
    }
}
