//
//  DDCultureCollectionViewCell.swift
//  CHReadingBook
//
//  Created by zhuzi on 16/9/19.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class DDCultureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imagePic: UIImageView!
    @IBOutlet weak var imageViewPic: UIImageView!

    @IBOutlet weak var decriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imagePic.layer.shadowOpacity = 0.5
        imagePic.layer.shadowColor = UIColor.blackColor().CGColor
        imagePic.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        decriptionLabel.font = UIFont(name: "Hiragino Sans", size: 42 * pxSizePt)
    }

}
