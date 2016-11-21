//
//  ZJReadingViewController.swift
//  Scholar
//
//  Created by mac on 16/9/5.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class ZJReadingViewController: ZJMainVc, UITableViewDelegate, UITableViewDataSource {

    /** 动态模型数组 */
    var models = [ZJReading]()
    
    var modelFrist = [CHReadingHeader]()
    
    var index: NSIndexPath?
    
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let rightButton = UIButton(frame: CGRectMake(0, 0, SCREEN_SCALE_WIDTH * barItemSize, SCREEN_SCALE_HEIGHT * barItemSize))
        rightButton.setImage(UIImage(named: "sousuo_1124_98"), forState: .Normal)
        rightButton.addTarget(self, action: #selector(rightBarButton), forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        
        CHReadingHeader.loadHomeData { (result) in
            
            guard let result = result else {
                return
            }
            
            self.modelFrist = result
        }
        
        setupUI()
        
        tableView.mj_header = setupHeaderRefresh(self, action: #selector(pullDownRefesh))
        tableView.mj_footer = setupFooterRefresh(self, action: #selector(pullupMoreData))
        tableView.mj_header.beginRefreshing()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBarHidden = false
    }

    private func setupUI() {
        
        tableView.frame = self.view.bounds
        self.view.addSubview(tableView)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private lazy var tableView : UITableView = {
        let table = UITableView()
        table.registerClass(ZJReadingTableViewCell.self, forCellReuseIdentifier: "reading_cell")
        table.registerClass(ZJOneTableViewCell.self, forCellReuseIdentifier: "reading_cell1")
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .None
        return table
    }()
    
    /** 搜索 */
    @objc private func rightBarButton() {
        
        print("reading search -> ")
        let vc = ReadingSearchViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    deinit{
        print("remove Reading")
    }
    
}

// MARK: - tableView delegate and datasource
extension ZJReadingViewController {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return modelFrist.count ?? 0
        }else if section == 1 {
        
            return models.count ?? 0
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            
            var cell = tableView.dequeueReusableCellWithIdentifier("reading_cell1") as? ZJOneTableViewCell
            if cell == nil {
                cell = ZJOneTableViewCell(style: .Default, reuseIdentifier: "reading_cell1") as ZJOneTableViewCell
            }
            if modelFrist.count > indexPath.row {
                let model: CHReadingHeader = modelFrist[indexPath.row]
                cell?.models = model
            }

            let imageView = UIImageView()
            imageView.image = UIImage(named: "beijing_0_204")
            cell?.backgroundView = imageView
            
            return cell!
            
        }else {
            
            var cell = tableView.dequeueReusableCellWithIdentifier("reading_cell") as? ZJReadingTableViewCell
            if cell == nil {
                cell = ZJReadingTableViewCell(style: .Default, reuseIdentifier: "reading_cell") as ZJReadingTableViewCell
            }
            if models.count > indexPath.row {
                let model: ZJReading? = models[indexPath.row]
                cell?.models = model
            }

            let imageView = UIImageView()
            imageView.image = UIImage(named: "beijing_0_204")
            cell?.backgroundView = imageView
            
            return cell!
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return SCREEN_SCALE_HEIGHT * 450
        }else {
        
            return SCREEN_SCALE_HEIGHT * 350
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)

        let vc = ZJPersonalInformationViewController()
        
        if indexPath.section == 0 {
            
            let modelOne = modelFrist[0]
            vc.userInfoID = Int(modelOne.committee_id!)
            vc.setupBookID(modelOne.committee_id!, book_pic: modelOne.book_pic!)
        }else if indexPath.section == 1 {
            
            let model = models[indexPath.row]
            vc.userInfoID = Int(model.committee_id!)
            vc.setupBookID(model.committee_id!, book_pic: model.book_pic!)
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

/** load net data */
extension ZJReadingViewController {

    //请求数据
    private func loadData(method: Int, page: Int) {
        
        ZJReading.loadHomeData(page) { (result) in
            
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            
            guard let result = result else {
                self.tableView.mj_footer.endRefreshingWithNoMoreData()
                return
            }
            if method == 0 {
                self.models = result
            }else {
                self.models += result
            }
            
            self.tableView.reloadData()
        }
    }
}
