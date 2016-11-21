//
//  CHReadingSearch.swift
//  CHReadingBook
//
//  Created by mac on 2016/10/13.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class CHReadingSearch: NSObject {
  
    var book_author: String?
    
    var book_name:   String?
    
    var book_id:     String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    class func loadSearchData(searchText: String, finished: ((result: [CHReadingSearch]?) -> ())) {
        
        var models = [CHReadingSearch]()
        
        /// 注意泛型, 因为这是swift3中强制的语法
        let parameters:[String : AnyObject] = ["book_name": searchText]
        
        CHNetworkTools.sharedNetworkTool.post(READING_SEARCH, parameters: parameters) { (success, result, error) in
            
            guard let result = result where result["status"] == "success" else {
                finished(result: nil)
                return
            }
            
            let data = result["list"].arrayObject as? [[String : AnyObject]]
            
            for dict in data! {
                
                models.append(CHReadingSearch(dict: dict))
            }
            
            finished(result: models)
            return
        }
    }
}
