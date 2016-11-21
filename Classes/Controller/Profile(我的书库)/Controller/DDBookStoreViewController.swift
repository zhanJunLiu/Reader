//
//  DDBookStoreViewController.swift
//  CHReadingBook
//
//  Created by zhuzi on 16/9/18.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class DDBookStoreViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var collection: UICollectionView?
    var model: [DDBookCaseModel]?


    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
        collection!.mj_header = setupHeaderRefresh(self, action: #selector(DDCollectViewController.loadNewData))
        collection!.mj_footer = setupFooterRefresh(self, action: #selector(DDCollectViewController.loadMoreData))
        collection!.mj_header.beginRefreshing()
    }
    
    //下拉刷新
    func loadNewData() {
        loadData(0)
    }
    //上拉加载
    func loadMoreData() {
        loadData(1)
    }

    //MARK: - 创建UI
    func createUI() {
        //创建网格布局对象
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
//        flowLayout.itemSize = CGSizeMake((SCREEN_W - 20) / 3, 160)
        flowLayout.minimumInteritemSpacing = 0
        //cell行距
        flowLayout.minimumLineSpacing = 0
        
        //创建网格对象
        self.collection = UICollectionView(frame: CGRectMake(0, 0, SCREEN_W, SCREEN_H - (SCREEN_H/4 + 64 + 44)), collectionViewLayout: flowLayout)
        self.collection!.delegate = self
        self.collection!.dataSource = self
        
        self.collection?.backgroundColor = UIColor.whiteColor()
        //关闭竖向滑条
        self.collection!.showsVerticalScrollIndicator = false
        self.view.addSubview(self.collection!)
        
        //注册cell
        let nib = UINib(nibName: "DDBookStoreCollectionViewCell", bundle: nil)
        self.collection!.registerNib(nib, forCellWithReuseIdentifier: "DDBookStoreCollectionViewCell")
    }
    
    //MARK: - 代理方法
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DDBookStoreCollectionViewCell", forIndexPath: indexPath) as! DDBookStoreCollectionViewCell
        
//        cell.bookPic.image = UIImage(named: "03委员读书_03")
//        cell.decritionLabel.text = "03委员读书_03"
        
        cell.imageViewPic.image = UIImage(named: "bei jing")
        let bookcaseModel = model![indexPath.row]
         cell.bookPic.yy_setImageWithURL(NSURL(string: "\(BASE_URL)\(bookcaseModel.book_pic)"), placeholder: UIImage(named: "03委员读书_06"))
        cell.decritionLabel.text = bookcaseModel.book_name
        
        return cell
        
    }
    
    //设置item的大小
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(SCREEN_W / 3, SCREEN_H / 3 - 30)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let modelHeader = model![indexPath.row]
        
        let vc = CHBuyCoverViewController()
        vc.imageName = modelHeader.book_pic
        vc.titles = modelHeader.book_name
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
        vc.bookid = "3"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension DDBookStoreViewController {
    func loadData(method: Int) {
        //请求数据

        
        let userid = "16"
        //        let userid = String(NSUserDefaults.standardUserDefaults().objectForKey("userID")!)
        DDBookCaseModel.loadCollectData(userid) { (result) in
            self.collection!.mj_header.endRefreshing()
            self.collection!.mj_footer.endRefreshing()
            guard let result = result else {
                self.collection!.mj_footer.endRefreshingWithNoMoreData()
                return
            }
            if method == 0 {
                self.model = result
            }else {
                self.model = result
            }
            self.collection!.reloadData()
        }
        
    }

}
