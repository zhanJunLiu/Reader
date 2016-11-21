//
//  ZJRecommend.swift
//  Scholar
//
//  Created by mac on 16/9/5.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

//"book_pdf_free" : "\/Uploads\/bookfile\/2016-09-14\/57d8eec9a9270.pdf",
//"book_description" : "官逼民反",
//"book_id" : "9",
//"book_pdf_money" : "\/Uploads\/bookfile\/2016-09-14\/57d8eec9a86b8.pdf",
//"book_copyright" : "人民大学出版社",
//"book_name" : "水浒传",
//"book_epub_money" : "\/Uploads\/bookfile\/2016-09-14\/57d8eec9a2126.epub",
//"book_time" : "2014-02-12",
//"book_epub_free" : "\/Uploads\/bookfile\/2016-09-14\/57d8eec9a53ef.epub",
//"book_catalog" : "林冲雪夜上梁山",
//"class2" : "182",
//"book_new_price" : "106",
//"book_classification" : "0",
//"book_pic" : "\/Uploads\/bookfile\/2016-09-14\/57d8eec9a9a40.jpg",
//"book_introduce" : "108好汉故事",
//"book_sell" : "1",
//"book_isbn" : "5001",
//"book_keyword" : "水波梁山",
//"book_old_price" : "107",
//"book_num" : "",
//"book_author" : "施耐庵",
//"book_page" : "180",
//"book_otherpic" : "\/Uploads\/bookfile\/2016-09-14\/57d8eec9aa9e0.png",
//"class1" : "181",
//"book_addtime" : "1473834697"

class ZJRecommend: NSObject {
    
    var book_pic:             String!//图书封面
    var book_name:            String!//图书名字
    var book_author:          String!//图书作者
    var book_description:     String!//图书描述
    var book_id:              String!//图书id
    var book_new_price:       String!//图书价格
    var book_pdf_free:        String!//试读url（.pdf）
    var book_epub_free:       String!//试读url（.epub）
    var book_read:            String!//阅读人数
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    class func loadHomeData(page: Int, finished: ((result: [ZJRecommend]?) -> ())) {
        
        var models = [ZJRecommend]()

        CHNetworkTools.sharedNetworkTool.get(READRECOMMED_URL + "/p/\(page)", parameters: nil) { (success, result, error) in
            
            print("分页: \(page)")
            
            guard let result = result where result["status"] == "success" else {
                finished(result: nil)
                return
            }
            
            let data = result["list"].arrayObject as! [[String: AnyObject]]
            
            for dict  in data {
                
                models.append(ZJRecommend(dict: dict))
            }
            
            finished(result: models)
            
            return
        }
    }
}
