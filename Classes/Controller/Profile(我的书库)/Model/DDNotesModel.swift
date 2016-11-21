//
//  DDNotesModel.swift
//  CHReadingBook
//
//  Created by zhuzi on 2016/10/26.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class DDNotesModel: NSObject {
    
    var note_description:       String!//笔记内容
    var note_date:              String!//笔记日期
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    class func loadNotesData(finished: ((result: [DDNotesModel]?)->())) {
        
        var models = [DDNotesModel]()
        
        CHNetworkTools.sharedNetworkTool.get(ADD_NOTES, parameters: nil) { (success, result, error) in
         
            print("笔记内容: \(result)")
            
            guard let result = result where result["status"] == "success" else {
                return
            }
            let data = result["list"].arrayObject as? [[String : AnyObject]]
            if data == nil {
                return
            }else {
                for dict in data! {
                    models.append(DDNotesModel(dict: dict))
                }
                finished(result: models)
            }
            return
        }
    }
}
