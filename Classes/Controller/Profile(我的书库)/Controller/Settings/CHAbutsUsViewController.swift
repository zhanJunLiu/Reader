//
//  CHAbutsUsViewController.swift
//  CHReadingBook
//
//  Created by macbook on 2016/11/11.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class CHAbutsUsViewController: ZJMainVc {
    
    var iconImg: UIImageView!
    var iconDis: UIImageView!
    var provenance: UIImageView! // 出处
    var versions: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "关于我们"
        
        iconImg = UIImageView(image: UIImage(named: "tubiao_45"))
        view.addSubview(iconImg)
        iconImg?.snp_makeConstraints(closure: { (make) in
            make.size.equalTo(CGSize(width: SCREEN_SCALE_WIDTH * 230, height: SCREEN_SCALE_HEIGHT * 230))
            make.centerX.equalTo(view.snp_centerX)
            make.centerY.equalTo(view.snp_centerY).offset(SCREEN_SCALE_HEIGHT * -150)
        })
        
        iconDis = UIImageView(image: UIImage(named: "shuxiangzhengxie"))
        view.addSubview(iconDis)
        iconDis?.snp_makeConstraints(closure: { (make) in
            make.centerX.equalTo(iconImg)
            make.top.equalTo(iconImg.snp_bottom).offset(SCREEN_SCALE_HEIGHT * 30)
            make.size.equalTo(CGSize(width: SCREEN_SCALE_WIDTH * 320, height: SCREEN_SCALE_HEIGHT * 80))
        })
        
        provenance = UIImageView(image: UIImage(named: "banquansuoyou"))
        view.addSubview(provenance)
        provenance.snp_makeConstraints { (make) in
            make.centerX.equalTo(iconImg)
            make.bottom.equalTo(view).offset(SCREEN_SCALE_HEIGHT * -200)
            make.size.equalTo(CGSize(width: SCREEN_SCALE_WIDTH * 524, height: SCREEN_SCALE_HEIGHT * 44))
        }
        
        versions = UIImageView(image: UIImage(named: "banben"))
        view.addSubview(versions)
        versions.snp_makeConstraints { (make) in
            make.centerX.equalTo(provenance)
            make.top.equalTo(provenance.snp_bottom).offset(SCREEN_SCALE_HEIGHT * 20)
            make.size.equalTo(CGSize(width: SCREEN_SCALE_WIDTH * 210, height: SCREEN_SCALE_HEIGHT * 43))
        }
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
