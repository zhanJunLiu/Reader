//
//  ZJSearchTableViewCell.swift
//  Scholar
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class ZJSearchTableViewCell: UITableViewCell {
    
    var book_name : UILabel!
    var user_name : UILabel!
    var data:       CHSearch!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        book_name = UILabel()
        self.contentView.addSubview(book_name)
        book_name.snp_makeConstraints { (make) in
            make.center.equalTo(contentView)
            make.right.equalTo(contentView.snp_centerX)
            make.left.equalTo(contentView).offset(SCREEN_SCALE_WIDTH * 30)
        }
        
        user_name = UILabel()
        self.contentView.addSubview(user_name)
        user_name.snp_makeConstraints { (make) in
            make.top.equalTo(book_name)
            make.left.equalTo(book_name.snp_right)
            make.right.equalTo(contentView).offset(SCREEN_SCALE_WIDTH * -30)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        book_name.text = "<<\(data.book_name ?? "")>>"
        user_name.text = data.book_author
    }
    
}
