//
//  GuidePageView.h
//  LoveLife
//
//  Created by 杨阳 on 16/6/7.
//  Copyright © 2016年 yangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuidePageView : UIView

//点击跳转页面的按钮
@property(nonatomic,strong) UIButton * goInButton;

-(id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray;



@end
