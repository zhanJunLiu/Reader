//
//  UIImage+Extension.swift
//  CHReadingBook
//
//  Created by mac on 16/9/15.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

extension UIImageView {

    convenience init(imageName: String) {
        self.init(image: UIImage(named: imageName))
    }
}
