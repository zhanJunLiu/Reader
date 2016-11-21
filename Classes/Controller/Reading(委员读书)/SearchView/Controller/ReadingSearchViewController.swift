//
//  ReadingSearchViewController.swift
//  CHReadingBook
//
//  Created by mac on 2016/10/13.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

/** tableView id */
private let id = "reading_search_cell"

class ReadingSearchViewController: ZJMainVc {

    var models : [CHReadingSearch] = [CHReadingSearch]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        setupNav()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerClass(CHReadingSearchCell.self, forCellReuseIdentifier: id)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private func setupUI() {
        tableView.frame = self.view.bounds
        self.view.addSubview(tableView)
    }
    
    
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

extension ReadingSearchViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

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
        
        CHReadingSearch.loadSearchData(keywords) { (result) in
            
            guard let result = result else {
                CHProgressHUD.showInfoWithStatus("没有相关内容!")
                return
            }
            
            weakSelf!.models = result
            weakSelf!.tableView.reloadData()
        }
    }

    /// 搜索条件点击
    func sortButtonClick() {
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(id) as? CHReadingSearchCell
        
        if cell != nil {
            cell = CHReadingSearchCell(style: .Default, reuseIdentifier: id) as CHReadingSearchCell
        }
        
        if models.count > indexPath.row {
            cell?.data = models[indexPath.row]
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        
    }
    
    
}

