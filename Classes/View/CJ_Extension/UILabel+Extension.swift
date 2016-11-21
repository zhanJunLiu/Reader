
import Foundation
import UIKit

extension UILabel {
    
    
    
    /// 创建 UILabel
    ///
    /// - parameter text:      text
    /// - parameter fontSize:  fontSize，默认 14
    /// - parameter color:     color，默认 darkGrayColor
    /// - parameter alignment: alignment，默认左对齐
    ///
    /// - returns: UILabel
    convenience init(ch_text text: String,
                             fontSize: CGFloat = 14,
                             color: UIColor = UIColor.darkGrayColor(),
                             alignment: NSTextAlignment = .Left) {
        
        self.init()
        
        self.text = text
        self.textColor = color
        self.font = UIFont.systemFontOfSize(fontSize)
        self.textAlignment = alignment
        
        self.numberOfLines = 0
        
        // 自动调整大小
        sizeToFit()
    }


    /**
     自定义Label
     - author: 刘战军
     
     - parameter text:			文本信息
     - parameter fontSize:	    字体大小:默认15
     - parameter color:			字体颜色:默认灰色
     
     */
    
    func mt_setText (text text: String, fontSize: CGFloat = 15, color: UIColor = UIColor.darkGrayColor()) {
        
        self.text = text
        self.textColor = color
        self.font = UIFont.systemFontOfSize(fontSize)
        self.numberOfLines = 0
        
        sizeToFit()
    }
    
    
    
    public func setText(text:String = "" ,font:UIFont,color:UIColor){
        if text.isQaulity(){
            self.text = text
        }
        self.font = font
        self.textColor = color
    }
    
}