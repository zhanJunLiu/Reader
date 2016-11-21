//
//  MTTextField.swift
//  art-teacher
//
//  Created by 路政浩 on 16/8/1.
//  Copyright © 2016年 com.etudetime. All rights reserved.
//

import UIKit

class MTTextField: UITextField {
    
    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(20, 3, bounds.size.width - 20, bounds.size.height)
    }
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(20, 3, bounds.size.width - 20, bounds.size.height)
    }
}
