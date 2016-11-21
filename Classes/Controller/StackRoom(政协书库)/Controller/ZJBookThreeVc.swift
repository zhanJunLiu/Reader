//
//  ZJBookThreeVc.swift
//  Scholar
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class ZJBookThreeVc: ZJMainVc,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    var models: [DDPoliticsYearbook]?
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
        self.collection?.registerClass(CHCultureCell.self, forCellWithReuseIdentifier: "thred_Cell")
        self.collection!.delegate = self
        self.collection!.dataSource = self
        self.collection!.showsVerticalScrollIndicator = false
        self.collection?.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.collection!)
        
        //注册cell
//        let nib = UINib(nibName: "DDCultureCollectionViewCell", bundle: nil)
//        self.collection!.registerNib(nib, forCellWithReuseIdentifier: "DDCultureCollectionViewCell")
        
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
        return self.models?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("thred_Cell", forIndexPath: indexPath) as! CHCultureCell
        
        let model = models![indexPath.row]
        
        cell.imgView!.yy_setImageWithURL(NSURL(string: "\(BASE_URL)\(model.book_pic)"), placeholder: UIImage(named: ""))
        cell.imgTitle!.text = model.book_name
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: SCREEN_W / 3, height: (SCREEN_H - 64 - 44) / 3)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let model = models![indexPath.row]
        let vc = CHCoverViewController()
        vc.imageName = model.book_pic
        vc.titles = model.book_name
        vc.author = model.book_author
        vc.readingCount = "30"
        vc.fileSize = "20K"
        vc.descriptions = model.book_description
        vc.money = model.book_new_price
        vc.readingURL = model.book_epub_free
        vc.bookid = model.book_id
        self.navigationController?.pushViewController(vc, animated: true)
        collectionView.deselectItemAtIndexPath(indexPath, animated: false)
        self.index = indexPath
    }
    
    
}

extension ZJBookThreeVc {
    //MARK: - 请求数据
    private func loadData(method: Int) {
        
        DDPoliticsYearbook.loadHomeData { (result) in
            
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
