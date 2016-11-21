//
//  DDHeaderSetting.swift
//  CHReadingBook
//
//  Created by zhuzi on 16/9/27.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class DDHeaderSetting: NSObject {
    
    var book_id:              String!//图书id
    var book_pic:             String!//图书封面
    var book_name:            String!//图书名字
    var book_author:          String!//图书作者
    var book_description:     String!//图书描述
    var book_new_price:       String!//图书价格
    var book_pdf_free:        String!//试读url（.pdf）
    var book_epub_free:       String!//试读url（.epub）
    var book_read:            String!//阅读人数
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }

    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    class func loadHomeData(finished: ((result: [DDHeaderSetting]?) -> ())) {
        
        var models = [DDHeaderSetting]()
        
        CHNetworkTools.sharedNetworkTool.get(HEADERSETTING_URL, parameters: nil) { (success, result, error) in
            
            guard let result = result where result["status"] == "success" else {
                return
            }
            let data = result["list"].arrayObject as? [[String: AnyObject]]
            for dict in data! {
                models.append(DDHeaderSetting(dict: dict))
            }
            finished(result: models)
            
            return
        }
    }

}
