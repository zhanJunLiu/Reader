//
//  DDNoteDetailsViewController.swift
//  CHReadingBook
//
//  Created by zhuzi on 16/9/19.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class DDNoteDetailsViewController: UIViewController {
    
    var tableView = UITableView()
    var model : [DDNotesModel]?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "笔记详情"
        
        createUI()
        tableView.mj_header = setupHeaderRefresh(self, action: #selector(DDNoteDetailsViewController.loadNewData))
        tableView.mj_header.beginRefreshing()
    }
    
    func loadNewData() {
        loadData(0)
    }
    
    //创建UI
    func createUI() {
        
        tableView.frame = CGRectMake(0, -64, SCREEN_W, SCREEN_H-64-44)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        //注册cell
        let nib = UINib(nibName: "DDNoteDetailsTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "DDNoteDetailsTableViewCell")
    }

}

extension DDNoteDetailsViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("DDNoteDetailsTableViewCell") as? DDNoteDetailsTableViewCell
        if cell == nil {
            cell = DDNoteDetailsTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "DDNoteDetailsTableViewCell") as DDNoteDetailsTableViewCell
        }
        
//        let model = LSYNoteModel()
//        cell?.detailsLabel.text = model.content
        
//        let content = NSUserDefaults.standardUserDefaults().objectForKey("content")
//        let date = NSUserDefaults.standardUserDefaults().objectForKey("date")
        
        if model == nil {
            CHProgressHUD.showInfoWithStatus("主人还没做📒")
            cell?.dataLabel.text = ""
            cell?.detailsLabel.text = ""
            cell?.annotateLabel.text = ""
        }else {
//            cell?.detailsLabel.text = String(content!)
//            cell?.dataLabel.text = "· \(String(date!))"
            
            let NoteModels = model![indexPath.row]
            cell?.detailsLabel?.text = NoteModels.note_description
            cell?.dataLabel.text = NoteModels.note_date
            
            cell?.annotateLabel.text = "注| 以后千万要注意"
        }
        
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 310 * SCREEN_SCALE_HEIGHT
    }
    
    //请求数据
    func loadData(method: Int) {
        DDNotesModel.loadNotesData { (result) in
            
            self.tableView.mj_header.endRefreshing()
            guard let result = result else {
                return
            }
            self.model = result
            self.tableView.reloadData()
        }
    }
}