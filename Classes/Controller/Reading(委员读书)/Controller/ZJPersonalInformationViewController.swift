//
//  ZJPersonalInformationViewController.swift
//  Book
//
//  Created by mac on 16/9/12.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

/** 书名文字大小 */
private let book_name_Size: CGFloat = 16

/** 作者文字大小 */
private let nick_name_Size: CGFloat = 16

/** 作者 */
private let user_Icon_Size: CGFloat = 80

/** 收藏分享按钮大小 */
private let cellectSize:    CGFloat = 45

let UMENG_SHARE_TEXT = "点帮帮里程碑"
let UMENG_MILESTONE_SHARE_TEXT = "点帮帮里程碑"
let UMENG_INVITE_SHARE_TEXT = "发现一款好玩的APP,点帮帮，快来下载吧，下载地址是http://bangbang.pointgongyi.com"
let ABOUT_US_URL = "http://bangbang.pointgongyi.com"

class ZJPersonalInformationViewController: ZJMainVc {
    
    var modelAll: [CHUserData] = [CHUserData]()
    
    var book_pic: String!
    
    let shareView = ShareView.init(frame: CGRectMake(0, 0, SCREEN_W, SCREEN_H))
    
    var selectButton = UIButton()
    
    private var collect: NSMutableArray? {
        var collect = NSMutableArray()
//        collect = DetailTool.collectDealLine() as! NSMutableArray
        return collect
    }
    
    var userInfoID: Int! {
        didSet{
            
            print("模型中请求数据:\(userInfoID)")
            CHUserData.loadHomeData(userInfoID) { (result) in /** 因为不能够将请求到的数据赋值给模型数组, 所以在直接请求到数据之后赋值给控件 */
                guard let result = result else {
                    return
                }
                self.modelAll = result
                let model = result[0]
                self.book_Name.text = model.book_name
                self.book_Name.font = UIFont(name: "Hiragino Sans", size: 62 * pxSizePt)
                self.user_Icon.yy_setImageWithURL(NSURL(string: "\(BASE_URL)\(model.committee_ren_head ?? "")"), placeholder: UIImage(named: "占位图"))
                self.nick_Name.text = model.committee_ren_name
                self.nick_Name.font = UIFont(name: "Hiragino Sans", size: 60 * pxSizePt)
                self.shuPin_description.text = model.committee_book_details
                self.shuPin_description.font = UIFont(name: "Hiragino Sans", size: 40 * pxSizePt)
                self.bookName.text = model.book_name
                self.bookName.font = UIFont(name: "Hiragino Sans", size: 62 * pxSizePt)
                self.book_icon.yy_setImageWithURL(NSURL(string: "\(BASE_URL)\(self.book_pic ?? "")"), placeholder: UIImage(named: "tuzuo"))
                self.book_icon.layer.shadowOpacity = 0.5
                self.book_icon.layer.shadowColor = UIColor.blackColor().CGColor
                self.book_icon.layer.shadowOffset = CGSize(width: 0, height: -5)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavToolBar()
        setupUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didClickLoginOK), name: kThirdLoginKey, object: nil)
        
        self.navigationController?.navigationBarHidden = false
        
        selectButton.selected = true
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kThirdLoginKey, object: nil)
    }
    
    /** 监听第三方登录成功 */
    @objc private func didClickLoginOK() {
        
        shareView.removeFromSuperview()
    }
    
    /** 设置收藏分享按钮 */
    private func setNavToolBar() {
    
        let tools = UIToolbar(frame: CGRectMake(150, 0, SCREEN_SCALE_WIDTH * 138, SCREEN_SCALE_HEIGHT * 80))
        tools.clipsToBounds = true
        tools.setBackgroundImage(UIImage(), forToolbarPosition: .Any, barMetrics: .Default)
        tools.setShadowImage(UIImage(), forToolbarPosition: .Any)
        
        // 添加两个button
        var buttons = [UIBarButtonItem]()
        let button_3 = UIButton(frame: CGRectMake(0, 0, SCREEN_SCALE_WIDTH * cellectSize, SCREEN_SCALE_HEIGHT * cellectSize))
        button_3.setImage(UIImage(named: "fenxiang_1113_101"), forState: .Normal)
        button_3.addTarget(self, action: #selector(didClickShareButton(_:)), forControlEvents: .TouchUpInside)
        let button3 = UIBarButtonItem(customView: button_3)
        
        
        let button_2 = UIButton(frame: CGRectMake(0, 0, SCREEN_SCALE_WIDTH * cellectSize, SCREEN_SCALE_HEIGHT * cellectSize))
        button_2.setImage(UIImage(named: "shoucang_normal_951_101"), forState: UIControlState.Normal)
        button_2.setImage(UIImage(named: "shoucang_selected_951_101"), forState: UIControlState.Selected)
        selectButton = button_2
        button_2.addTarget(self, action: #selector(didClickCellectButton(_:)), forControlEvents: .TouchUpInside)
        let button2 = UIBarButtonItem(customView: button_2)
        button2.tintColor = UIColor.whiteColor()
        buttons.append(button2)
        buttons.append(button3)
        tools.setItems(buttons, animated: false)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tools)
    }
    
    /** 收藏按钮点击事件 */
    @objc private func didClickCellectButton(button: UIButton) {
        
        let userid = "16"
//        let userid = String(NSUserDefaults.standardUserDefaults().objectForKey("userID")!)
        
        let bookModel = self.modelAll
        let bookid = bookModel[0].book_id
        let committeeid = String(userInfoID)
        let committeerenid = bookModel[0].committee_ren_id
        
        
        DDCollectModel.loadCollectData(userid, bookid: bookid!, committeeid: committeeid, committeerenid: committeerenid!) { (result) in
            
            guard let result = result else {
                
                self.selectButton.selected = true
                let alertview = UIAlertView(title: "", message: "已收藏", delegate: self, cancelButtonTitle: "确定")
                alertview.show()
                return
            }
            
            let alertview = UIAlertView(title: "", message: "收藏", delegate: self, cancelButtonTitle: "确定")
            alertview.show()
            print("result: \(result)")
        }
        
        print("点击收藏按钮")
    }
    
    /** 分享按钮点击事件 */
    @objc private func didClickShareButton(button: UIButton) {
        
        
        shareView.setShareModel("\(self.shuPin_description.text ?? "")\(UMENG_INVITE_SHARE_TEXT)", image: UIImage(named: "datuzhong")!, url: ABOUT_US_URL, title: "\(self.book_Name.text! ?? "")  评书作者:\(self.nick_Name.text ?? "")")
        shareView.showInViewController(self)
    }
    
    
    
    /** 接受book_id */
    func setupBookID(userInfo_id: String, book_pic: String) {
    
        self.book_pic = book_pic
    }
    
    private func setupUI() {
    
        
        view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBarHidden = false
        bookShelves.setBackgroundImage(UIImage(named: "chakan"), forState: .Normal)
        bookShelves.addTarget(self, action: #selector(didClickReadingButton(_:)), forControlEvents: .TouchUpInside)
        
        view.addSubview(book_Name)
        view.addSubview(user_Icon)
        view.addSubview(nick_Name)
        view.addSubview(bottomView)
        view.addSubview(shuPin_description)
        
        book_Name.snp_makeConstraints { (make) in
            make.top.equalTo(view).offset(SCREEN_SCALE_HEIGHT * 180)
            make.left.equalToSuperview().offset(SCREEN_SCALE_WIDTH * 20)
            make.right.equalToSuperview().offset(SCREEN_SCALE_WIDTH * -20)
            make.height.equalTo(SCREEN_SCALE_HEIGHT * 40)
        }
        
        user_Icon.snp_makeConstraints { (make) in
            make.top.equalTo(book_Name.snp_bottom).offset(SCREEN_SCALE_HEIGHT * 20)
            make.left.equalTo(book_Name)
            make.size.equalTo(CGSizeMake(SCREEN_SCALE_WIDTH * user_Icon_Size, SCREEN_SCALE_HEIGHT * user_Icon_Size))
        }
        
        nick_Name.snp_makeConstraints { (make) in
            make.centerY.equalTo(user_Icon)
            make.left.equalTo(user_Icon.snp_right).offset(SCREEN_SCALE_WIDTH * 10)
        }
        
        bottomView.snp_makeConstraints { (make) in
            make.bottom.equalTo(view).offset(SCREEN_SCALE_HEIGHT * -20)
            make.left.equalToSuperview().offset(SCREEN_SCALE_WIDTH * 20)
            make.right.equalToSuperview().offset(SCREEN_SCALE_WIDTH * -20)
            make.height.equalTo(SCREEN_SCALE_HEIGHT * 350)
        }
        
        shuPin_description.snp_makeConstraints { (make) in
            make.top.equalTo(user_Icon.snp_bottom).offset(SCREEN_SCALE_HEIGHT * 20)
            make.left.equalTo(user_Icon)
            make.right.equalTo(bottomView)
            make.bottom.equalTo(bottomView.snp_top).offset(SCREEN_SCALE_HEIGHT * -20)
        }
        
        bottomView.addSubview(book_icon)
        book_icon.snp_makeConstraints { (make) in
            make.top.equalToSuperview().offset(SCREEN_SCALE_HEIGHT * 20)
            make.bottom.equalToSuperview().offset(SCREEN_SCALE_HEIGHT * -20)
            make.left.equalToSuperview().offset(SCREEN_SCALE_WIDTH * 40)
            make.width.equalTo(SCREEN_SCALE_WIDTH * 200)
        }
        
        bottomView.addSubview(bookName)
        bookName.snp_makeConstraints { (make) in
            make.top.equalToSuperview().offset(SCREEN_SCALE_HEIGHT * 200)
            make.left.equalTo(book_icon.snp_right).offset(SCREEN_SCALE_WIDTH * 50)
            make.right.equalToSuperview().offset(SCREEN_SCALE_WIDTH * -50)
            make.height.equalTo(SCREEN_SCALE_HEIGHT * 40)
        }
        
        bottomView.addSubview(bookShelves)
        bookShelves.snp_makeConstraints { (make) in
            make.centerX.equalTo(bookName)
            make.top.equalTo(bookName.snp_bottom).offset(SCREEN_SCALE_HEIGHT * 20)
            make.bottom.equalToSuperview().offset(SCREEN_SCALE_HEIGHT * -20)
//            make.size.equalTo(CGSizeMake(SCREEN_SCALE_WIDTH * 250, SCREEN_SCALE_HEIGHT * 70))
            make.width.equalTo(SCREEN_SCALE_WIDTH * 250)
        }
    }
    
    @objc private func didClickReadingButton(sender: UIButton) {
        
        if ZJAccountModel.isLogin() {
            let booksell = modelAll[0].book_sell
            if booksell == "1" {
                let vc = CHCoverViewController()
                //        vc.imageName = modelHeader.book_pic
                vc.imageName = modelAll[0].book_pic
                //        vc.titles = modelHeader.book_name
                vc.titles = modelAll[0].book_name
                //        vc.author = modelHeader.book_author
                vc.author = "刘"
                vc.readingCount = "30"
                vc.fileSize = "20K"
                //        vc.descriptions = modelHeader.book_description
                vc.descriptions = "23456789"
                //        vc.money = modelHeader.book_new_price
                vc.money = "0.2"
                //        vc.readingURL = modelHeader.book_epub_free
                vc.readingURL = "erjkofdkf"
                //        vc.bookid = modelHeader.book_id
                vc.bookid = modelAll[0].book_id
                
                self.navigationController?.pushViewController(vc, animated: true)
            }else {
                CHProgressHUD.showInfoWithStatus("已下架")
            }
        }else {
            
            let loginVc = ZJLoginViewController()
            self.navigationController?.pushViewController(loginVc, animated: true)
        }
    }
    
    private lazy var book_Name: UILabel = {
        let title = UILabel(ch_text: "", fontSize: book_name_Size, color: UIColor.blackColor(), alignment: .Left)
        return title
    }()
   
    private lazy var nick_Name: UILabel = {
        let nick = UILabel()

        return nick
    }()
    
    private lazy var user_Icon: UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    
    private lazy var shuPin_description: UITextView = {
        let des = UITextView()
        des.userInteractionEnabled = false
        des.multipleTouchEnabled = false
        return des
    }()
    
    private lazy var bottomView: UIImageView = {
        let bottomV = UIImageView()
        bottomV.image = UIImage(named: "beijing")
        bottomV.userInteractionEnabled = true
        return bottomV
    }()
    
    private lazy var book_icon : UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    
    private lazy var bookName: UILabel = {
        let bookName = UILabel(ch_text: "", fontSize: 17, color: UIColor.blackColor(), alignment: .Center)
        return bookName
    }()
    
    private lazy var bookShelves: UIButton = {
        let shelves = UIButton()
        return shelves
    }()
    
}

