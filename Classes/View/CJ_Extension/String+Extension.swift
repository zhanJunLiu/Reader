






import Foundation
import UIKit

extension String{
    
    public var length: Int{
        get{
            return (self as NSString).length ?? 0
        }
    }
    
    /**
     计算输入文字的size
     
     - parameter font:              字体大小
     - parameter constrainedToSize:
     
     - returns:根据字体大小 计算文字的size
     */
    public func size(font:UIFont,constrainedToSize:CGSize = CGSizeZero) -> CGSize{
        //将调用者转换成NSString
        let string = self as NSString
        
        //设置字体属性
        let attr = [
            NSFontAttributeName:font
        ]
        
        return  string.boundingRectWithSize(constrainedToSize, options: [NSStringDrawingOptions.UsesLineFragmentOrigin], attributes: attr, context: nil).size
        
    }
    
    /**
     判断字符串的长度是否大于0
     
     - returns: 不是空字符串就返回true  是空的就返回 false
     */
    public func isQaulity()->Bool {
        if self.characters.count > 0 {
            return true
        } else {
            return false
        }
        
    }
    
    /**
     判断两个字符串是否相同
     
     - parameter str: 比较的字符串
     
     - returns: 返回是否相同
     */
    public func isEqualToStr(str:String) -> Bool{
        
        if (self as NSString).isEqualToString(str){
            return true
        } else {
            return false
        }
    }
    
    /**
     判断用户输入的手机号是否正确
     
     - returns: 
     */
    public func isTelNumber()->Bool{
        
        let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        /**
         * 移动号段正则表达式
         */
        let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        /**
         * 联通号段正则表达式
         */
        let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        /**
         * 电信号段正则表达式
         */
        let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluateWithObject(self) == true)
            || (regextestcm.evaluateWithObject(self)  == true)
            || (regextestct.evaluateWithObject(self)  == true)
            || (regextestcu.evaluateWithObject(self)  == true))
        {
            return true
        }
        else
        {
            return false
        }
    }
}