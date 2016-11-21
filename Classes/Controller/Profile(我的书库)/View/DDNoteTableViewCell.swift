//
//  DDNoteTableViewCell.swift
//  CHReadingBook
//
//  Created by zhuzi on 16/9/19.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class DDNoteTableViewCell: UITableViewCell {

    @IBOutlet weak var bookPic: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recordLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
