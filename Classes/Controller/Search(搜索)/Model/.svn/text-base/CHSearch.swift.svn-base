//
//  CHSearch.swift
//  CHReadingBook
//
//  Created by mac on 2016/10/12.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class CHSearch: NSObject {
    
    var book_author: String?
    
    var book_name:   String?
    
    var book_id:     String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    class func loadSearchData(searchText: String, finished: ((result: [CHSearch]?) -> ())) {
    
        var models = [CHSearch]()
        
        /// 注意泛型, 因为这是swift3中强制的语法
        let parameters:[String : AnyObject] = ["book_name": searchText]
        
        CHNetworkTools.sharedNetworkTool.post(SEARCH, parameters: parameters) { (success, result, error) in
            
            guard let result = result where result["status"] == "success" else {
                finished(result: nil)
                return
            }
            
            let data = result["list"].arrayObject as? [[String : AnyObject]]
            
            if data == nil {
                finished(result: nil)
                return
            }else {
            
                for dict in data! {
                    
                    models.append(CHSearch(dict: dict))
                }
                finished(result: models)
            }
            
            return
        }
    }
}
