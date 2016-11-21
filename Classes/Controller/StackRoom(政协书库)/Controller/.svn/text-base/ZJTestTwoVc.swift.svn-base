//
//  ZJTestTwoVc.swift
//  Scholar
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class ZJTestTwoVc: ZJMainVc,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    var models: [DDTestModel]?
    var recommendModel: [ZJRecommend]?
    var detailsFaceModel: [DDDetailsFace]?
    
    
    var index:  NSIndexPath?
    
    var collection: UICollectionView?
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        loadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
        
        collection!.mj_header = setupHeaderRefresh(self, action: #selector(pullDownRefesh))
        collection!.mj_footer = setupFooterRefresh(self, action: #selector(pullupMoreData))
        collection!.mj_header.beginRefreshing()
    }
    
    /** 下拉刷新 */
    @objc private func pullDownRefesh() {
        
        loadData(0)
    }
    
    
    /** 上拉刷新 */
    @objc private func pullupMoreData() {
        
        loadData(1)
    }
    
    //MARK: - 创建UI
    func createUI() {
        //创建网格布局对象
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        
        //创建网格对象
        self.collection = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        self.collection!.delegate = self
        self.collection!.dataSource = self
        self.collection!.showsVerticalScrollIndicator = false
        self.collection?.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.collection!)
        
        //注册cell
        let nib = UINib(nibName: "DDCultureCollectionViewCell", bundle: nil)
        self.collection!.registerNib(nib, forCellWithReuseIdentifier: "DDCultureCollectionViewCell")
        
    }
    
    /** 点击试读按钮时的操作 */
    @objc private func didClickFirstReadingButton(sender: UIButton) {
        
        let model = recommendModel![(index?.row)!]
        
        /** 这里进行数据的下载 */
        //        dispatch_async(dispatch_get_main_queue()) {
        //
        //            CHNetworkTools.sharedNetworkTool.downloadEpubFile(model.book_epub_money, fileName: model.book_name)
        //
        //        }
        //
        //        print(model.book_epub_money)
        
        
        NSThread.sleepForTimeInterval(5)
        
        let pageView = LSYReadPageViewController()
        
        //        let fileURL = NSBundle.mainBundle().URLForResource(model.book_name, withExtension: "epub")
        let fileURL = NSBundle.mainBundle().pathForResource(model.book_name, ofType: "epub")
        print(fileURL)
        let url = NSURL(string: fileURL!)
        
        
        pageView.resourceURL = url
        pageView.model = LSYReadModel.getLocalModelWithURL(url) as! LSYReadModel
        self.presentViewController(pageView, animated: true, completion: nil)
    }
    
    
    
    //代理方法
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DDCultureCollectionViewCell", forIndexPath: indexPath) as! DDCultureCollectionViewCell
        
        let model = models![indexPath.row]
        
        
        cell.imagePic.yy_setImageWithURL(NSURL(string: "\(BASE_URL)\(model.book_pic)"), placeholder: UIImage(named: ""))
        cell.decriptionLabel.text = model.book_name
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: SCREEN_W / 3, height: SCREEN_H / 3 - 30)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let model = models![indexPath.row]
    
        let coverView = ZJCoverView(frame: CGRectMake(0, 0, SCREEN_W, SCREEN_H), imageName: model.book_pic, title: model.book_name, author: model.book_author, readingCount: "30", fileSize: "20k", description: model.book_description, money: model.book_new_price)
        coverView.shoppingCar.addTarget(self, action: #selector(didClickFirstReadingButton(_:)), forControlEvents: .TouchUpInside)
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.addSubview(coverView)
        
        collectionView.deselectItemAtIndexPath(indexPath, animated: false)
        self.index = indexPath
    }
    
    
}

extension ZJTestTwoVc {
    //MARK: - 请求数据
    private func loadData(method: Int) {
        
        DDTestModel.loadHomeData { (result) in
            
            print(result)
            print(NSThread.isMainThread())
            self.collection!.mj_header.endRefreshing()
            self.collection!.mj_footer.endRefreshing()
            guard let result = result else {
                self.collection!.mj_footer.endRefreshingWithNoMoreData()
                return
            }
            
            if method == 0 {
                
                self.models = result
            }else {
                self.models = result
            }
            
//            self.models = result
            self.collection!.reloadData()
            
        }
        
    }
    
}
