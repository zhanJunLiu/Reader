//
//  DDNoteViewController.swift
//  CHReadingBook
//
//  Created by zhuzi on 16/9/19.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class DDNoteViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView = UITableView()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
    }
    
    //MARK: - 创建UI
    func createUI() {
        self.tableView = UITableView(frame: CGRectMake(0, -64, SCREEN_W, SCREEN_H-64-44), style: UITableViewStyle.Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        //注册cell
        let nib = UINib(nibName: "DDNoteTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "DDNoteTableViewCell")
    }
    
    //MARK: - 代理方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("DDNoteTableViewCell") as? DDNoteTableViewCell
        if  cell == nil {
            cell = DDNoteTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "DDNoteTableViewCell") as DDNoteTableViewCell
        }
        cell?.bookPic.image = UIImage(named: "03委员读书_09")
        cell?.titleLabel.text = "我在政协这一年"
        cell?.recordLabel.text = "5条笔记"
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 320 * SCREEN_SCALE_HEIGHT
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = DDNoteDetailsViewController()
        vc.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
