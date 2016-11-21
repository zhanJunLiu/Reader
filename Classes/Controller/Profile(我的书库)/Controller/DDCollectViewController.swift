//
//  DDCollectViewController.swift
//  CHReadingBook
//
//  Created by zhuzi on 16/9/18.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class DDCollectViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView = UITableView()
    var model: [DDCollectionModel]?
    
    var index: NSIndexPath?
    
    /** 接受沙盒中的解档数据 */
    var dealLines: NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
        tableView.mj_header = setupHeaderRefresh(self, action: #selector(DDCollectViewController.loadNewData))
        tableView.mj_footer = setupFooterRefresh(self, action: #selector(DDCollectViewController.loadMoreData))
        tableView.mj_header.beginRefreshing()
    }
    
    //下拉刷新
    func loadNewData() {
        loadData(0)
    }
    //上拉加载
    func loadMoreData() {
        loadData(1)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        /** 清空数组 */
        self.dealLines.removeAllObjects()
        
        /** 将沙盒中的集合添加到数据集合中 */
//        self.dealLines.addObjectsFromArray(DetailTool.collectDealLine())
        
        /** 添加完数据后, 因为有了新的数据, 所以添加数据 */
        self.tableView.reloadData()
    }
    
    //MARK: - 创建UI
    func createUI() {
        self.tableView = UITableView(frame: CGRectMake(0, 0, SCREEN_W, SCREEN_H - (SCREEN_H / 4 + 44)), style: UITableViewStyle.Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        //注册cell
        let nib = UINib(nibName: "DDCollecTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "DDCollecTableViewCell")
    }
    
    //MARK: - 代理方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("DDCollecTableViewCell") as? DDCollecTableViewCell
        if cell == nil {
            cell = DDCollecTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "DDCollecTableViewCell") as DDCollecTableViewCell
        }

        let collecModel = model![indexPath.row]
        cell?.iconImage.yy_setImageWithURL(NSURL(string: "\(BASE_URL)\(collecModel.committee_ren_head)"), placeholder: UIImage(named: "03委员读书_06"))
        cell?.iconNameLabel.text = collecModel.committee_ren_name
        cell?.bookPic.yy_setImageWithURL(NSURL(string: "\(BASE_URL)\(collecModel.book_pic)"), placeholder: UIImage(named: "03委员读书_09"))
        cell?.iconTitleLabel.text = collecModel.committee_book_title
        cell?.iconDescriptionLabel.text = collecModel.committee_book_details
        cell?.iconCommentLabel.text = "评《\(collecModel.book_name)》"
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 320 * SCREEN_SCALE_HEIGHT
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = DDCollectDetailsViewController()
        vc.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //MARK - 左滑删除
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}


extension DDCollectViewController {

    func loadData(method: Int) {
        //请求数据
//        DDCollectionModel.loadCollectData { (result) in
//            self.tableView.mj_header.endRefreshing()
//            self.tableView.mj_footer.endRefreshing()
//            guard let result = result else {
//                self.tableView.mj_footer.endRefreshingWithNoMoreData()
//                return
//            }
//            if method == 0 {
//                self.model = result
//            }else {
//                self.model = result + result
//            }
//            self.tableView.reloadData()
//        }
        
        let userid = "16"
//        let userid = String(NSUserDefaults.standardUserDefaults().objectForKey("userID")!)
        DDCollectionModel.loadCollectData(userid) { (result) in
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            guard let result = result else {
                self.tableView.mj_footer.endRefreshingWithNoMoreData()
                return
            }
            if method == 0 {
                self.model = result
            }else {
                self.model = result
            }
            self.tableView.reloadData()
        }

    }
}
