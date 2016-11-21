//
//  ZJSearchViewController.swift
//  Scholar
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class ZJSearchViewController: ZJMainVc, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var models: [CHSearch] = [CHSearch]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /** 让导航栏显示出来 */
        self.navigationController?.navigationBarHidden = false
        // Do any additional setup after loading the view.
        setupNav()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupUI() {
        
        tableView.frame = self.view.bounds
        self.view.addSubview(tableView)
    }
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.registerClass(UITableViewCell.self, forCellReuseIdentifier: "search_cell")
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    // 设置导航栏
    func setupNav() {
        
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: #selector(navigationBackClick))
    }
    
    /// 返回按钮、取消按钮点击
    func navigationBackClick() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "搜索"
        return searchBar
    }()
}


extension ZJSearchViewController {
    
    /// 搜索按钮点击
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "checkUserType_backward_9x15_"), style: .Plain, target: self, action: #selector(navigationBackClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_sort_21x21_"), style: .Plain, target: self, action: #selector(sortButtonClick))
        /// 根据搜索条件进行搜索
        let keyword = searchBar.text
//        weak var weakSelf = self
//        YMNetworkTool.shareNetworkTool.loadSearchResult(keyword!, sort: "") { (results) in
//            weakSelf!.results = results
//            weakSelf!.collectionView!.reloadData()
//        }
        
        weak var weakSelf = self
        
        guard let keywords = keyword else {
            return
        }
        
        CHSearch.loadSearchData(keywords) { (result) in
            
            guard let result = result else {
                CHProgressHUD.showInfoWithStatus("没有相关内容!")
                return
            }
            
            weakSelf!.models = result
            weakSelf!.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("search_cell") as? ZJSearchTableViewCell
        if cell == nil {
            
            cell = ZJSearchTableViewCell(style: .Default, reuseIdentifier: "search_cell") as ZJSearchTableViewCell
        }
        
        if self.models.count > indexPath.row {
            
            cell?.data = models[indexPath.row]
        }
        
        return cell!
    }
    
    /// 搜索条件点击
    func sortButtonClick() {
//        popView.show()
    }
    
}
