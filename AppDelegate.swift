//
//  AppDelegate.swift
//  Reader
//
//  Created by macbook on 2016/11/20.
//  Copyright © 2016年 刘战军. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // 给注册推送时用 - 因为注册推送想在主界面加载出来才询问是否授权
    var launchOptions: [NSObject: AnyObject]?
    
    //创建guidePageView
    var guidePageView = GuidePageView()
    var tabVc = ZJTabBarController()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        setupAppearance()        /** 设置全局外观属性 */
        setupRootViewController()/** 设置根控制器 */
        setupShareSDK()          /** 设置shareSDK */
        setupGlobalData()        /** 配置全局数据 */
//        setupJPushUI(launchOptions)
        addGuidePageView()       /** 添加引导页 */
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate: WXApiDelegate{
    
    /// 设置全局外观, 一经设置全局有效
    private func setupAppearance() {
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        CHProgressHUD.setupHUD() // 配置HUD
    }
    
    /// 设置跟控制器
    private func setupRootViewController() {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        window?.backgroundColor = UIColor.whiteColor()
        
        window?.rootViewController = ZJTabBarController()
        
        window?.makeKeyAndVisible()
    }
    
    /** 配置shareSDK */
    private func setupShareSDK() {
        /**
         1. 新浪微博
         997. 微信平台
         998. QQ平台
         */
        ShareSDK.registerApp(SHARESDK_LOGIN_KEY, activePlatforms: [SSDKPlatformType.TypeWechat.rawValue, SSDKPlatformType.TypeQQ.rawValue, SSDKPlatformType.TypeSinaWeibo.rawValue], onImport: { (platformType) in
            
            switch platformType {
                
            case SSDKPlatformType.TypeWechat: ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                break
            case SSDKPlatformType.TypeQQ: ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.self)
                break
//            case SSDKPlatformType.TypeSinaWeibo: ShareSDKConnector.connectWeibo(WeiboSDK.classForCoder())
//                break
            default:
                break
            }
            
        }) { (platformType, appInfo) in
            
            switch platformType {
            //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
//            case SSDKPlatformType.TypeSinaWeibo: appInfo.SSDKSetupSinaWeiboByAppKey(WB_APP_KEY, appSecret: WB_APP_SECRET, redirectUri: WB_REDIRECT_URL, authType: SSDKAuthTypeBoth)
//                break
                
            case SSDKPlatformType.TypeWechat: appInfo.SSDKSetupWeChatByAppId(WX_APP_ID, appSecret: WX_APP_SECRET)
                break
            case SSDKPlatformType.TypeQQ: appInfo.SSDKSetupQQByAppId(QQ_APP_ID, appKey: QQ_APP_KEY, authType: SSDKAuthTypeBoth)
                break
            default:
                break
            }
        }
        
        //注册微信登录
        WXApi.registerApp(WX_APP_ID, withDescription: "ch_ReadingBook")
        
        /** 短信验证 */
        SMSSDK.registerApp(SHARE_APP_KEY, withSecret: SHARE_APP_SECRET)
    }
    
    /** 配置全局数据 */
    private func setupGlobalData() {
        // 验证缓存的账号是否有效
        ZJAccountModel.checkToken()
    }
    //onReq是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。
    //在调用sendRsp返回时，会切回到微信终端程序界面。
    func onReq(req: BaseReq!) {
        
    }
    
    //如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。
    //sendReq请求调用后，会切到微信终端程序界面。
    func onResp(resp: BaseResp!) {
        if resp.isKindOfClass(SendAuthResp) {
            //微信登录
            WeChat.weChatLoginIsOk(resp)
        } else if resp.isKindOfClass(PayResp){
            //微信支付
            WeChat.weChatPayIsOk(resp)
        }
    }
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        
        WXApi.handleOpenURL(url, delegate: self)
        
        //支付宝支付的回调
        if url.host!.isEqualToStr("safepay"){
            AlipaySDK.defaultService().processOrderWithPaymentResult(url)
            {
                CHAliPay.zhifubaoPayCallBack($0)
            }
        }
        
        if url.host!.isEqualToStr("platformapi"){
            AlipaySDK.defaultService().processAuthResult(url)
            {
                CHAliPay.zhifubaoPayCallBack($0)
            }
        }
        
        return true
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        
        WXApi.handleOpenURL(url, delegate: self)
        
        //支付宝支付的回调
        if url.host!.isEqualToStr("safepay"){
            
            AlipaySDK.defaultService().processOrderWithPaymentResult(url) { (resultDict) in
                print("支付跳转支付宝钱包进行支付:\(resultDict)")
                CHAliPay.zhifubaoPayCallBack(resultDict!)
            }
            
            
            AlipaySDK.defaultService().processAuth_V2Result(url) { (resultDict) in
                print("授权跳转支付钱包进行支付:\(resultDict)")
                CHAliPay.zhifubaoPayCallBack(resultDict!)
            }
            
        }
        return true
    }
    
    //添加引导页
    func addGuidePageView() {
        if ((NSUserDefaults.standardUserDefaults().objectForKey("isRan")?.boolValue) != nil) {
            return
        }
        let array = ["xinshuguide", "shukuguide", "dushuguide", "qidongyeguide"]
        self.guidePageView = GuidePageView.init(frame: self.window!.bounds, imageArray: array)
        NSUserDefaults.standardUserDefaults().setObject(true, forKey: "isRan")
        tabVc.view.addSubview(self.guidePageView)
        
        self.guidePageView.goInButton.addTarget(self, action: #selector(AppDelegate.goInButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    //按钮响应方法
    func goInButtonClick() {
        self.guidePageView.removeFromSuperview()
    }
}

///MARK: - 推送
extension AppDelegate{
    
    /// 推送
//    func setupJPushUI(launchOptions: [NSObject: AnyObject]?) {
//        self.launchOptions = launchOptions
//        self.window?.rootViewController = tabVc
//    }
    
}
