//
//  DDMessageViewController.swift
//  CHReadingBook
//
//  Created by zhuzi on 16/9/22.
//  Copyright © 2016年 mac. All rights reserved.
//

let fontsize: CGFloat = 15.0
let kGCCardRatio = 0.8
let kGCCardWidth = (CGRectGetWidth(UIScreen.mainScreen().bounds) * CGFloat(kGCCardRatio))
let kGCCardHeight = kGCCardWidth / CGFloat(kGCCardRatio)

import UIKit

class DDMessageViewController: UIViewController,CardScrollViewDelegate,CardScrollViewDataSource {
    
    var cardScrollView = CardScrollView()
    var cards = NSMutableArray()
    var backButton = UIButton()
    var card = UIView()
    var backView = UIImageView()
    var model: DDMessageModel? = nil
    var models: DDMessageModel? = nil
    var dataArray = NSMutableArray()
    
    
    var MessageModel: [DDMessageModel]?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建背景imageView
        createBackImageView()
        
        self.cardScrollView = CardScrollView(frame: self.view.frame)
        self.cardScrollView.cardDelegate = self
        self.cardScrollView.cardDataSource = self
        self.backView.addSubview(self.cardScrollView)
        
//        self.dataArray.addObject(model!)
//        for i in 0..<dataArray.count {
//            self.cards.addObject(i)
//        }
        
        
        //返回按钮
        createButton()
        
//        loadData()
        
//        loadArrayData()
    }
    
    func loadArrayData() {
        //请求数据
        DDMessageModel.loadMessageData { (result) in
            //            print(result)
            guard let result = result else {
                return
            }
            
            self.models = result[0]
            self.dataArray.addObject(self.model!)
            for i in 0..<self.dataArray.count {
                self.cards.addObject(i)
            }
            
        }
    }
    
    
    //MARK: - 创建背景imageView
    func createBackImageView() {
        self.backView = UIImageView(frame: self.view.frame)
        self.backView.image = UIImage(named: "beijing-1")
        self.backView.userInteractionEnabled = true
        view.addSubview(backView)
    }
    
    
    //MARK: - 创建返回按钮
    func createButton() {
        self.backButton = UIButton(type: UIButtonType.Custom)
        self.backButton.frame = CGRect(x: SCREEN_W / 2-20, y: (SCREEN_H-kGCCardHeight)/2+kGCCardHeight+20, width: 40, height: 40)
        self.backButton.setImage(UIImage(named: "shanchu"), forState: UIControlState.Normal)
        self.backButton.addTarget(self, action: #selector(DDMessageViewController.buttonClick), forControlEvents: UIControlEvents.TouchUpInside)
        self.backView.addSubview(self.backButton)
        
    }
    
    
    //MARK: - 为button添加相应事件
    func buttonClick() {
        self.dismissViewControllerAnimated(true) { 
            print("我回去了~~~~~~")
        }
    }
    
    override func viewDidLayoutSubviews() {
        self.cardScrollView.loadCard()
    }
    
    //MARK: - CardScrollViewDelegate
    func updateCard(card: UIView!, withProgress progress: CGFloat, direction: CardMoveDirection) {
        if direction == CardMoveDirection.None {
            if card.tag != self.cardScrollView.currentCard() {
                let scale: CGFloat = 1 - 0.1 * progress
                card.layer.transform = CATransform3DMakeScale(scale, scale, 1.0)
                card.layer.opacity = 1 - 0.2 * Float(progress)
            }
            else {
                card.layer.transform = CATransform3DIdentity
                card.layer.opacity = 1
            }
        } else {
            let transCardTag = direction == CardMoveDirection.Left ? self.cardScrollView.currentCard() + 1 : self.cardScrollView.currentCard() - 1
            if card.tag != self.cardScrollView.currentCard() && card.tag == transCardTag {
                card.layer.transform = CATransform3DMakeScale(0.9 + 0.1 * progress, 0.9 + 0.1 * progress, 1.0)
                card.layer.opacity = 0.8 + 0.2 * Float(progress)
            }
            else if card.tag == self.cardScrollView.currentCard() {
                card.layer.transform = CATransform3DMakeScale(1 - 0.1 * progress, 1 - 0.1 * progress, 1.0)
                card.layer.opacity = 1 - 0.2 * Float(progress)
            }
            
        }
    }
    
    //MARKL: - CardScrollViewDataSource
    func numberOfCards() -> Int {
//        return self.cards.count
//        return self.dataArray.count
        return 2
    }
    
    func cardReuseView(reuseView: UIView!, atIndex index: Int) -> UIView! {
        if (reuseView != nil) {
            // you can set new style
            return reuseView
        }
        card = UIView(frame: CGRect(x: 0, y: 0, width: kGCCardWidth * 0.9, height: kGCCardHeight))
        card.layer.backgroundColor = UIColor.whiteColor().CGColor
        card.layer.cornerRadius = 4
        card.layer.masksToBounds = true
        
        //创建imageView
        let imageViewHeader = UIImageView(frame: CGRectMake(0, 0, card.width, card.height / 3 * 2 - 15))
        imageViewHeader.image = UIImage(named: "委员笔记_11")
        card.addSubview(imageViewHeader)
        
        //创建title
        let titleLabel = UILabel(frame: CGRectMake(SCREEN_SCALE_WIDTH*70, imageViewHeader.height+10, card.width - SCREEN_SCALE_WIDTH*140, SCREEN_SCALE_HEIGHT*30))
        titleLabel.text = "人民政协文史资料展"
        titleLabel.textAlignment = NSTextAlignment.Center
        card.addSubview(titleLabel)
        
        //创建timeLabel
        let timeLabel = UILabel(frame: CGRectMake(SCREEN_SCALE_WIDTH*50, titleLabel.y + titleLabel.height, SCREEN_SCALE_WIDTH*90, SCREEN_SCALE_HEIGHT*50))
        timeLabel.text = "时间:"
        timeLabel.font = UIFont.systemFontOfSize(fontsize)
        card.addSubview(timeLabel)
        
        //创建timeDetailsLabel
        let timeDetailsLabel = UILabel(frame: CGRectMake(timeLabel.x+timeLabel.width, titleLabel.y + titleLabel.height, card.width - SCREEN_SCALE_WIDTH*100, SCREEN_SCALE_HEIGHT*50))
        timeDetailsLabel.text = "2016年4月27号"
        timeDetailsLabel.font = UIFont.systemFontOfSize(fontsize)
        card.addSubview(timeDetailsLabel)
        
        //创建littleTimeLabel
        let littleTimeLabel = UILabel(frame: CGRectMake(timeLabel.x+timeLabel.width, timeDetailsLabel.y + timeDetailsLabel.height, card.width - SCREEN_SCALE_WIDTH*140, SCREEN_SCALE_HEIGHT*50))
        littleTimeLabel.text = "10:00-20:00"
        littleTimeLabel.font = UIFont.systemFontOfSize(fontsize)
        card.addSubview(littleTimeLabel)
        
        //创建addressLabel
        let addressLabel = UILabel(frame: CGRectMake(SCREEN_SCALE_WIDTH*50, littleTimeLabel.y + littleTimeLabel.height, SCREEN_SCALE_WIDTH*90, SCREEN_SCALE_HEIGHT*50))
        addressLabel.text = "地址:"
        addressLabel.font = UIFont.systemFontOfSize(fontsize)
        card.addSubview(addressLabel)
        
        //创建addressDetailsLabel
        let addressDetailsLabel = UILabel(frame: CGRectMake(addressLabel.x+addressLabel.width, littleTimeLabel.y + littleTimeLabel.height, card.width - SCREEN_SCALE_WIDTH*140, addressLabel.height))
        addressDetailsLabel.text = "北京市西城区太平桥大街23号"
        addressDetailsLabel.font = UIFont.systemFontOfSize(fontsize)
        card.addSubview(addressDetailsLabel)
        
        
        
        //请求数据
        DDMessageModel.loadMessageData { (result) in
            //            print(result)
            guard let result = result else {
                return
            }
            
            self.model = result[index]
            self.dataArray.addObject(self.model!)
            for i in 0..<result.count {
                self.cards.addObject(i)
            }
            
            imageViewHeader.yy_setImageWithURL(NSURL(string: "\(BASE_URL)"+self.model!.activity_pic), placeholder: nil)
            titleLabel.text = self.model!.activity_title
            timeDetailsLabel.text = "\(self.model!.activity_time)-\(self.model!.activity_time2)"
            littleTimeLabel.text = "\(self.model!.activity_time3)-\(self.model!.activity_time4)"
            addressDetailsLabel.text = self.model!.activity_address
            
        }

        
        //创建button
        let buttonMore = UIButton(type: UIButtonType.Custom)
        buttonMore.frame = CGRectMake(SCREEN_SCALE_WIDTH*170, addressDetailsLabel.y + addressDetailsLabel.height, card.width - SCREEN_SCALE_WIDTH*340, SCREEN_SCALE_HEIGHT*70)
        buttonMore.tag = index
        buttonMore.setImage(UIImage(named: "more"), forState: UIControlState.Normal)
        buttonMore.addTarget(self, action: #selector(DDMessageViewController.buttonClickc(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        card.addSubview(buttonMore)
        
        
        
        return card
    }
    
    //button的响应方法
    @objc private func buttonClickc(button: UIButton) {
        
        let activityDetails = DDActivityDetailsViewController()
        
        switch button.tag {
        case 0:
            activityDetails.activityID = "10"
        case 1:
            activityDetails.activityID = "1"
        default:
            print("不合理的数据")
        }
    
        self.presentViewController(activityDetails, animated: true, completion: {})
    }
    
    func deleteCardWithIndex(index: Int) {
        self.cards.removeObjectAtIndex(index)
    }

}


extension DDMessageViewController {
    private func loadData() {
        //请求数据
        DDMessageModel.loadMessageData { (result) in
            print(result)
            guard let result = result else {
                return
            }
            self.MessageModel = result

        }
    }
}
