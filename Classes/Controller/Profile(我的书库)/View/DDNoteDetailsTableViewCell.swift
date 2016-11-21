//
//  DDNoteDetailsTableViewCell.swift
//  CHReadingBook
//
//  Created by zhuzi on 2016/10/17.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class DDNoteDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var annotateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
