//
//  DDLearnDataModel.swift
//  CHReadingBook
//
//  Created by zhuzi on 16/9/28.
//  Copyright © 2016年 mac. All rights reserved.
//

let num1: Int = 1

import UIKit

class DDLearnDataModel: NSObject {
    
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
    
    class func loadHomeData(finished: ((result: [DDLearnDataModel]?) -> ())) {
        
        var models = [DDLearnDataModel]()
        
        print("第一分类: \(BASE_URL)\(POLITICALBOOKCASE_URL)/\(num1)")
        
        CHNetworkTools.sharedNetworkTool.get(POLITICALBOOKCASE_URL+String(num1), parameters: nil) { (success, result, error) in
            
            guard let result = result where result["status"] == "success" else {
                return
            }
            
            let data = result["list"].arrayObject as? [[String: AnyObject]]
            
            if data == nil {
                return
            }
            
            for dict  in data! {
                models.append(DDLearnDataModel(dict: dict))
            }
            
            finished(result: models)
            return
        }
    }
}
