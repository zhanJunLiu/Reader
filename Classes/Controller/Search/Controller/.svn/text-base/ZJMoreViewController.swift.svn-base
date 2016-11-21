//
//  ZJMoreViewController.swift
//  Book
//
//  Created by mac on 16/9/12.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

/** 注册时使用的ID */
private let ID = "collection_cell"


class ZJMoreViewController: UIViewController, LYScrollViewDelegate {

    var scrollView: LYScrollView!
    
    var itemArray:  NSMutableArray!
    
    var imageView:  UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupUI() {
        imageView = UIImageView(frame: view.frame)
        view.addSubview(imageView)
        imageView.backgroundColor = UIColor.lightGrayColor()
        itemArray = NSMutableArray()
        for i in 0...7 {
            itemArray.addObject(UIImage(named: "\(i).jpg") ?? "")
            let button = UIButton()
            button.backgroundColor = UIColor.blueColor()
            button.frame = CGRectMake(20, 20, 40, 40)
            button.tag = i
            imageView.addSubview(button)
        }
        imageView.image = blurViewByLightEffectWithImage(itemArray[0] as! UIImage)
        imageView.userInteractionEnabled = true
        scrollView = LYScrollView(frame: view.frame)
        scrollView.delegate = self
        scrollView.isOpenDelete = true
        scrollView.itmeArray = self.itemArray
        view.addSubview(scrollView)

        
    }
    
    func scrolIndex(index: Int) {
        if itemArray.count > index {
            imageView.image = blurViewByLightEffectWithImage(itemArray[index] as! UIImage)
        }
        
        print(index)
        
    }
    
    private func blurViewByLightEffectWithImage(screenImage: UIImage) -> UIImage {
        let blurImage = UIImageEffects.imageByApplyingLightEffectToImage(screenImage)
        return blurImage
    }


//    private lazy var collectionView: UICollectionView = {
//        
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.itemSize = CGSizeMake(SCREEN_W * 0.8, SCREEN_SCALE_HEIGHT * 700)
//        flowLayout.scrollDirection=UICollectionViewScrollDirection.Horizontal
//        flowLayout.minimumLineSpacing=20
//        flowLayout.minimumInteritemSpacing = 10
//        let collection = UICollectionView(frame: CGRectMake(0, 100, self.view.frame.size.width, SCREEN_SCALE_HEIGHT * 1000), collectionViewLayout: flowLayout)
//        collection.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: ID)
//        return collection
//    }()
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension ZJMoreViewController {
//    
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ID, forIndexPath: indexPath)
//        
//        cell.backgroundColor = UIColor.redColor()
//        
//        return cell
//    }
//    
//}


