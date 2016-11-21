//
//  CHUserData.swift
//  CHReadingBook
//
//  Created by mac on 16/9/27.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
class CHUserData: NSObject {
    
    var committee_ren_id:      String?
    
    var committee_ren_name:    String?
    
    var committee_ren_head:    String?
    
    var book_id:               String?
    
    var book_name:             String?
    
    var book_pic:              String?
    
    var book_sell:             String?
    
    var book_copyright:        String?
    
    var committee_book_title:  String?
    
    var committee_book_details: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    class func loadHomeData(committee_id: Int, finished: ((result: [CHUserData]?) -> ())) {
        
        var models = [CHUserData]()
        
        let url = "\(BASE_URL)/index.php/committeeReadBook/information/id/\(committee_id ?? 0)"
        print("个人资料url: \(url)")
        
        CHNetworkTools.sharedNetworkTool.get("/index.php/committeeReadBook/information/id/\(committee_id)", parameters: nil) { (success, result, error) in
            
            guard let result = result where result["status"] == "success" else {
                finished(result: nil)
                return
            }
            
            let data = result["list"].arrayObject as? [[String : AnyObject]]
            
            for dict in data! {
                
                models.append(CHUserData(dict: dict))
            }
            
            finished(result: models)
            return
        }
    }
}
