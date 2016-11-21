//
//  DDCultureModel.swift
//  CHReadingBook
//
//  Created by zhuzi on 16/9/26.
//  Copyright © 2016年 mac. All rights reserved.
//

let num7: Int = 7

import UIKit

class DDCultureModel: NSObject {
    
    var book_pic:               String!//图书封面
    var book_name:              String!//图书名字
    var book_id:                String!//图书id
    var product_classify_id:    String!//分类id
    var book_author:            String!//图书作者
    var book_new_price:         String!//图书价格
    var book_pdf_free:          String!//试读url（.pdf）
    var book_epub_free:         String!//试读url（.epub）
    var book_read:              String!//阅读人数
    var book_description:       String!//图书描述
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    class func loadHomeData(finished: ((result: [DDCultureModel]?) -> ())) {
        
        var models = [DDCultureModel]()
        
        
        CHNetworkTools.sharedNetworkTool.get(POLITICALBOOKCASE_URL+String(num7), parameters: nil) { (success, result, error) in
//            print(result!["list"])
            guard let result = result where result["status"] == "success" else {
                return
            }
            
            let data = result["list"].arrayObject as? [[String: AnyObject]]
//            print(data)
            
            
            for dict  in data! {
                models.append(DDCultureModel(dict: dict))
            }
            
            finished(result: models)
            
            return
        }
    }
}

    

