//
//  ZJStackRoomViewController.swift
//  Scholar
//
//  Created by mac on 16/9/5.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class ZJStackRoomViewController: ZJMainVc {
    
    var line =  UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightButton = UIButton(frame: CGRectMake(0, 0, SCREEN_SCALE_WIDTH * barItemSize, SCREEN_SCALE_HEIGHT * barItemSize))
        rightButton.setImage(UIImage(named: "sousuo_1124_98"), forState: .Normal)
        rightButton.addTarget(self, action: #selector(rightBarButton), forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        
        // 设置约束问题
        automaticallyAdjustsScrollViewInsets = false
        
        var style = SegmentStyle()
        
        // 滚动条
        style.showLine = true
        // 颜色渐变
        style.gradualChangeTitleColor = false
        // 滚动条颜色
        style.scrollLineColor = ZJGlobalRedColor()
        // 滚动条的高度
        style.scrollLineHeight = 4
        // 遮盖的背景颜色
        style.coverBackgroundColor = ZJGlobalColor()
        //coverView的高度
        style.coverHeight = 44
        
        style.titleMargin = 4
        
        let titles = setChildVcs().map { $0.title! }
        
        let scroll = ScrollPageView(frame: CGRectMake(0, 64, view.bounds.size.width, view.bounds.size.height - 64), segmentStyle: style, titles: titles, childVcs: setChildVcs(), parentViewController: self)
        view.addSubview(scroll)
        
        line.frame = CGRect(x: 0, y: 64 + 44, width: SCREEN_W, height: 0.7)
        line.backgroundColor = UIColor.lightGrayColor()
        line.alpha = 0.5
        view.addSubview(line)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    @objc private func rightBarButton() {
        
        print("search -> ")
        let vc = ZJSearchViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setChildVcs() -> [UIViewController] {
        
//        let vc1 = ZJLearnOneVc()
//        vc1.title = "学习材料"
//        vc1.view.backgroundColor = UIColor.redColor()
        
        let vc2 = ZJTestTwoVc()
        vc2.title = "测试"
        vc2.view.backgroundColor = UIColor.yellowColor()
        
        let vc3 = ZJBookThreeVc()
        vc3.title = "文史资料"
        vc3.view.backgroundColor = UIColor.blueColor()
        
        let vc4 = ZJResearchFourVc()
        vc4.title = "文员书库"
        vc4.view.backgroundColor = UIColor.greenColor()
        
        let vc5 = ZJWorkFiveVc()
        vc5.title = "政协工作"
        vc5.view.backgroundColor = UIColor.orangeColor()
        
        let vc6 = ZJLibrarySixVc()
        vc6.title = "政协研究"
        vc6.view.backgroundColor = UIColor.purpleColor()
        
        let vc7 = ZJCultureHistorySevenVc()
        vc7.title = "政协年鉴"
        vc7.view.backgroundColor = UIColor.brownColor()
        
        return [vc3, vc4, vc5, vc6, vc7]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
