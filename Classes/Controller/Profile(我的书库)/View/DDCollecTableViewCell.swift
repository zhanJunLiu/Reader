//
//  DDCollecTableViewCell.swift
//  CHReadingBook
//
//  Created by zhuzi on 16/9/18.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class DDCollecTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var bookPic: UIImageView!
    @IBOutlet weak var iconNameLabel: UILabel!
    @IBOutlet weak var iconTitleLabel: UILabel!
    @IBOutlet weak var iconDescriptionLabel: UILabel!
    @IBOutlet weak var iconCommentLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImage.layer.masksToBounds = true
        iconImage.layer.cornerRadius = 20
        iconCommentLabel.textColor = UIColor.colorWithString("#ff5032")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
