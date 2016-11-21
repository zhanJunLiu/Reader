//
//  DDBuyRecordViewController.swift
//  CHReadingBook
//
//  Created by zhuzi on 16/9/19.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class DDBuyRecordViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView = UITableView()
    var model: [DDBookCaseModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建UI
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

    //创建UI
    func createUI() {
        self.tableView = UITableView(frame: CGRectMake(0, -64, SCREEN_W, SCREEN_H-64-44), style: UITableViewStyle.Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        //注册cell
        let nib = UINib(nibName: "DDBuyRecordTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "DDBuyRecordTableViewCell")
        
    }
    
    //MARK: 代理方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DDBuyRecordTableViewCell", forIndexPath: indexPath) as! DDBuyRecordTableViewCell
        
//        cell.bookPic.image = UIImage(named: "03委员读书_07")
//        cell.bookTitle.text = "我在政协这一年"
        
        let buyModel = model![indexPath.row]
        cell.bookPic.yy_setImageWithURL(NSURL(string: "\(BASE_URL)\(buyModel.book_pic)"), placeholder: UIImage(named: ""))
        cell.bookTitle.text = buyModel.book_name
        

        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 320 * SCREEN_SCALE_HEIGHT
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = DDBuyDetailsViewController()
        vc.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}


extension DDBuyRecordViewController {
    
    func loadData(method: Int) {
        
        let userid = "16"
//        let userid = String(NSUserDefaults.standardUserDefaults().objectForKey("userID")!)
        DDBookCaseModel.loadCollectData(userid) { (result) in
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
