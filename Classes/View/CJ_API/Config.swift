
import UIKit
import MJRefresh
import SwiftyJSON
///**
// 手机型号枚举
// */
//enum iPhoneModel {
//    
//    case iPhone4
//    case iPhone5
//    case iPhone6
//    case iPhone6p
//    case iPad
//    
//    
//    
//    /**
//     获取当前手机型号
//     
//     - returns: 返回手机型号枚举
//     */
//    static func getCurrentModel() -> iPhoneModel {
//        switch  SCREEN_H {
//        case 480:
//            return .iPhone4
//        case 568:
//            return .iPhone5
//        case 667:
//            return .iPhone6
//        case 736:
//            return .iPhone6p
//        default:
//            return .iPad
//        }
//    }
//}
//
/**
 快速创建上拉加载更多控件
 */
func setupFooterRefresh(target: AnyObject, action: Selector) -> MJRefreshFooter {
    let footerRefresh = MJRefreshBackNormalFooter(refreshingTarget: target, refreshingAction: action)
    footerRefresh.automaticallyHidden = true
    footerRefresh.setTitle("正在加载", forState: MJRefreshState.Refreshing)
    footerRefresh.setTitle("可以松开了", forState: MJRefreshState.Pulling)
    footerRefresh.setTitle("上拉加载更多", forState: MJRefreshState.Idle)
    footerRefresh.setTitle("没有啦~~~", forState: MJRefreshState.NoMoreData)
    return footerRefresh
}

/**
 快速创建下拉加载最新控件
 */
func setupHeaderRefresh(target: AnyObject, action: Selector) -> MJRefreshNormalHeader {
    let headerRefresh = MJRefreshNormalHeader(refreshingTarget: target, refreshingAction: action)
    headerRefresh.lastUpdatedTimeLabel.hidden = true
    headerRefresh.stateLabel.hidden = true
    return headerRefresh
}

///**
// 判断是否登录，如果没有登录则跳转到登录界面
// 
// - parameter controller: 当前控制器
// 
// - returns: 是否已经登录
// */
//func isLogin(controller: UIViewController) -> Bool {
//    
//    if ZJAccountModel.isLogin() {
//        return true
//    } else {
////        let loginVc = JFNavigationController(rootViewController: JFLoginViewController(nibName: "ZJLoginViewController", bundle: nil))
//        let loginVC = ZJLoginViewController()
//        let nav = ZJBaseNavVc(rootViewController: loginVC)
//        controller.presentViewController(nav, animated: true, completion: {
//            print("弹出登录界面")
//        })
//        return false
//    }
//}
//
///**
// 缓存json数据为指定json文件
// 
// - parameter json:     JSON对象
// - parameter jsonPath: json文件路径
// */
//func saveJson(json: JSON, jsonPath: String) {
//    do {
//        if let json = json.rawString() {
//            try json.writeToFile(jsonPath, atomically: true, encoding: NSUTF8StringEncoding)
//            print("缓存数据成功", jsonPath)
//        }
//    } catch {
//        print("缓存数据失败", jsonPath)
//    }
//}
//
//
///**
// 删除指定文件
// 
// - parameter jsonPath: 要删除的json文件路径
// */
//func removeJson(jsonPath: String) {
//    let fileManager = NSFileManager.defaultManager()
//    if fileManager.fileExistsAtPath(jsonPath) {
//        do {
//            try fileManager.removeItemAtPath(jsonPath)
//            print("删除成功", jsonPath)
//        } catch {
//            print("删除失败", jsonPath)
//        }
//    }
//}
//
///**
// 获取缓存的json数据
// 
// - parameter jsonPath: json文件路径
// 
// - returns: JSON对象
// */
//func getJson(jsonPath: String) -> JSON? {
//    if let data = NSData(contentsOfFile: jsonPath) {
//        print("获取缓存数据成功", jsonPath)
//        let json = JSON(data: data)
//        return json
//    }
//    print("获取缓存数据失败", jsonPath)
//    return nil
//}
//
/// 手机短信注册appKey
let SHARE_APP_KEY = "174d45dc18c2e"
let SHARE_APP_SECRET = "a8c5af61445b837692822ccacfc90f12"


/// shareSDK
let SHARESDK_APP_KEY = "57e37f2167e58ed265000781"
let SHARESDK_APP_SECRET = ""

/// shareSDK Login
let SHARESDK_LOGIN_KEY = "176518f19fe68"
let SHARESDK_LOGIN_SECRET = "6ed208dec6a1b2846f758715d8d765f1"

/// 微信
let WX_APP_ID = "wx6428e162ede92bf8"
let WX_APP_SECRET = "adba272c223a9cd9216504ff405c8097"

/// QQ
let QQ_APP_ID = "1105486631"
let QQ_APP_KEY = "wbo0uH1hbumWN569"
// 16进制的QQ_APP_ID = "41E46327"

/// 微博
let WB_APP_KEY = "3188092386"
let WB_APP_SECRET = "9d5a675faaf3a7fae74e80aa4c749bc0"
let WB_REDIRECT_URL = "http://www.baidu.com"
//  申请拿到的"access_token" = "2.001B_Z9Cw9ukTD0245003187UjIfrC";
//http://www.baidu.com

/// 极光推送
let JPUSH_APP_KEY = "262e1f311865192347262bd0"
let JPUSH_MASTER_SECRET = "9b9d4eda4d09b413e8159499"
let JPUSH_CHANNEL = "Publish channel"
let JPUSH_IS_PRODUCTION = true

/// 远程推送通知的处理通知
let JFDidReceiveRemoteNotificationOfJPush = "JFDidReceiveRemoteNotificationOfJPush"

/*ERR_OK = 0(用户同意)
 ERR_AUTH_DENIED = -4（用户拒绝授权）
 ERR_USER_CANCEL = -2（用户取消）*/
enum WeixinErrCode:Int32 {
    case Ok          = 0    //(用户同意)
    case UserCancel  = -2   //(用户取消)
    case UserDenied  = -4   //(用户拒绝授权）
}



