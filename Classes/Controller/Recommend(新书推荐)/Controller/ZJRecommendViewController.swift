//
//  ZJRecommendViewController.swift
//  Scholar
//
//  Created by mac on 16/9/5.
//  Copyright © 2016年 mac. All rights reserved.
//

let ZYTopViewH = SCREEN_SCALE_HEIGHT * 600

import UIKit
import Alamofire

class ZJRecommendViewController: ZJMainVc {
    
    var model: [DDHeaderSetting]?
    var models = [ZJRecommend]()
    var detailsFaceModel: [DDDetailsFace]?
    
    //创建背景
    var imageView = UIImageView()
    
    var index:  NSIndexPath?
    
    var page = 0
    
    //HomeHeader
    private  var collectionView : UICollectionView!
    private var flowLayout : LeftRightItem = LeftRightItem()
    let headImage = UIImageView()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //对navigationBar和navigationItem的设置
        setNavigationItemAndBar()
        
        DDHeaderSetting.loadHomeData { (result) in
            guard let result = result else {
                return
            }
            
            self.model = result
            self.collectionView.reloadData()
        }
        
        createBackView()
        setupUI()
        
        tableView.mj_header = setupHeaderRefresh(self, action: #selector(pullDownRefesh))
        tableView.mj_footer = setupFooterRefresh(self, action: #selector(pullupMoreData))
        tableView.mj_header.beginRefreshing()
    }
    
    //MARK - 对navigationBar和navigationItem的设置
    private func setNavigationItemAndBar() {
        
        //设置navigationBar为透明
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navback"), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage(named: "navback")
        
        
        createNavigationItemButton()
    }
    
    //MARK - 创建navigationItem左右button
    private func createNavigationItemButton() {
        
        let leftBtn = UIButton(type: UIButtonType.Custom)
        leftBtn.frame.size = CGSize(width: 20, height: 20)
        leftBtn.setImage(UIImage(named: "xiaoxi_58_98"), forState: UIControlState.Normal)
        leftBtn.addTarget(self, action: #selector(didClickMoreButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        let rightBtn = UIButton(type: UIButtonType.Custom)
        rightBtn.frame.size = CGSize(width: 20, height: 20)
        rightBtn.setImage(UIImage(named: "sousuo_1124_98"), forState: UIControlState.Normal)
        rightBtn.addTarget(self, action: #selector(didClickSearchButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
    }
    
    //MARK - 创建背景
    func createBackView() {
        imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "蓝色背景图")
        imageView.userInteractionEnabled = true
        view.addSubview(imageView)
    }
    
    deinit {
        print("\(self.debugDescription) --- 销毁")
    }
    
    /** 下拉刷新 */
    @objc private func pullDownRefesh() {
        page = 1
        loadData(0, page: page)
    }
    
    /** 上拉刷新 */
    @objc private func pullupMoreData() {
        page += 1
        loadData(1, page: page)
    }
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        
        table.registerClass(ZJRecommendTableViewCell.self, forCellReuseIdentifier: "recommend_cell")
        
        table.dataSource = self
        table.delegate = self
        
        return table
    }()
    
    private func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_SCALE_HEIGHT * 440)
        //HeaderSetting
        collectionView = UICollectionView(frame: CGRect.zero,collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate   = self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.showsHorizontalScrollIndicator = false
        headerView.addSubview(collectionView)
        collectionView.snp_makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(headerView.snp_top)
            make.bottom.equalTo(headerView.snp_bottom).offset(SCREEN_SCALE_HEIGHT * -20)
        }
        tableView.tableHeaderView = headerView
        tableView.backgroundColor = UIColor.clearColor()
        tableView.tableHeaderView?.backgroundColor = UIColor.clearColor()
        tableView.showsVerticalScrollIndicator = false
        imageView.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(view.snp_top).offset(64)
            make.bottom.equalTo(snp_bottomLayoutGuideTop)
            make.left.right.equalToSuperview()
        }
        
        //创建标题label
        let titleLabel = UILabel()
        titleLabel.text = "我在政协这一年"
        //        titleLabel.font = UIFont.systemFontOfSize(16)
        /** 需要40px */
        titleLabel.font = UIFont(name: "", size: pxSizePt * 40)
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.adjustsFontSizeToFitWidth = true
        headerView.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) in
           make.top.equalTo(collectionView.snp_bottom)
            make.bottom.equalTo(headerView)
            make.centerX.equalTo(headerView)
        }
    }
    
    /** 点击headerView */
    @objc private func didClickHeaderView(button: UIButton) {
        
        print("HeaderView -> ")
    }
    
    /** 点击更多按钮 */
    @objc private func didClickMoreButton(button: UIButton) {
        
        let moreVc = DDMessageViewController()
        self.navigationController?.presentViewController(moreVc, animated: true, completion: nil)
    }
    
    /** 点击搜索按钮 */
    @objc private func didClickSearchButton(button: UIButton) {
        
        let vc = ZJSearchViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

/// collectionView delegate
extension ZJRecommendViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        let headerModel = model![indexPath.row]
        let headImage = UIImageView(frame: cell.bounds)
        cell.contentView.addSubview(headImage)
        headImage.yy_setImageWithURL(NSURL(string: "\(BASE_URL)" + headerModel.book_pic), placeholder: UIImage(named: "委员笔记_11"))
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let modelHeader = model![indexPath.row]
        let vc = CHCoverViewController()
        vc.imageName = modelHeader.book_pic
        vc.titles = modelHeader.book_name
        vc.author = modelHeader.book_author
        vc.readingCount = modelHeader.book_read
        vc.fileSize = "20K"
        vc.descriptions = modelHeader.book_description
        vc.money = modelHeader.book_new_price
        vc.readingURL = modelHeader.book_epub_free
        vc.bookid = modelHeader.book_id
        self.navigationController?.pushViewController(vc, animated: true)
        collectionView.deselectItemAtIndexPath(indexPath, animated: false)
        self.index = indexPath
    }
}

/// tableView delegate
extension ZJRecommendViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("recommend_cell") as? ZJRecommendTableViewCell
        
        if cell == nil{
            cell = ZJRecommendTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "recommend_cell") as ZJRecommendTableViewCell
        }
        
        if indexPath.row == -1 {
            cell?.backgroundColor = UIColor.whiteColor()
            cell?.layer.masksToBounds = true
        }
        cell?.selectionStyle = .None
        
        if models.count > indexPath.row {
            let model: ZJRecommend? = models[indexPath.row]
            cell?.model = model
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return SCREEN_SCALE_HEIGHT * 300
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let modelFace = models[indexPath.row]
        let vc = CHCoverViewController()
        vc.imageName = modelFace.book_pic
        vc.titles = modelFace.book_name
        vc.author = modelFace.book_author
        vc.readingCount = modelFace.book_read
        vc.fileSize = "20K"
        vc.descriptions = modelFace.book_description
        vc.money = modelFace.book_new_price
        vc.readingURL = modelFace.book_epub_free
        vc.bookid = modelFace.book_id
        self.navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        self.index = indexPath
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cusSectionView = UIImageView()
            //        cusSectionView.backgroundColor = UIColor.colorWithString("#f8f8f8")
//        cusSectionView.layer.contents = UIImage(named: "paihang_0_1132")?.CGImage
        cusSectionView.image = UIImage(named: "paihang_0_1132_01")
        cusSectionView.contentMode = .ScaleAspectFill
//        cusSectionView.layer.shadowOpacity = 0.6
//        cusSectionView.layer.shadowColor = UIColor.blackColor().CGColor
//        cusSectionView.layer.shadowOffset = CGSize(width: 0, height: -5)
//        cusSectionView.layer.shadowColor = UIColor.blackColor().CGColor
//        cusSectionView.layer.shadowOffset = CGSizeMake(0, -10);
//        cusSectionView.layer.shadowOpacity = 1
//        cusSectionView.layer.cornerRadius = 10;
//        cusSectionView.layer.masksToBounds = true
        
//        let rect = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: SCREEN_SCALE_HEIGHT * 100)
//        let radio = CGSize(width: 5, height: 5)
//        let corner:UIRectCorner = [.TopLeft, .BottomLeft]
//        let path = UIBezierPath.init(roundedRect: rect, byRoundingCorners: corner, cornerRadii: radio)
//        let masklayer = CAShapeLayer()
//        masklayer.frame = cusSectionView.bounds
//        masklayer.path = path.CGPath
//        cusSectionView.layer.mask = masklayer
        
        let lbl = UILabel()
        lbl.text = "阅读排行"
        lbl.textColor = UIColor.colorWithString("#828282")
        cusSectionView.addSubview(lbl)
        lbl.snp_makeConstraints { (make) in
            make.bottom.equalTo(cusSectionView)
            make.left.equalTo(cusSectionView).offset(SCREEN_SCALE_WIDTH * 30)
        }
        return cusSectionView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SCREEN_SCALE_HEIGHT * 100
    }
    
    // 这个方法可以解决 tableView 的 HeaderView 的黏贴(悬浮)问题
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let sectionHeaderHeight: CGFloat = SCREEN_SCALE_HEIGHT * 100
        
        if scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0 {
            scrollView.contentInset = UIEdgeInsets(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0)
        }else if scrollView.contentOffset.y >= sectionHeaderHeight {
            scrollView.contentInset = UIEdgeInsets(top: -sectionHeaderHeight, left: 0, bottom: 0, right: 0)
        }
    }
}

/// 加载网络数据
extension ZJRecommendViewController {
    
    private func loadData(mothod: Int, page: Int) {
        
        ZJRecommend.loadHomeData(page) { (result) in
            
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            guard let result = result else {
                self.tableView.mj_footer.endRefreshingWithNoMoreData()
                return
            }
            if mothod == 0 {
                self.models = result
            }else {
                self.models += result
            }
            self.tableView.reloadData()
        }
    }
}
