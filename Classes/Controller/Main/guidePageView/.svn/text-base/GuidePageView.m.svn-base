//
//  GuidePageView.m
//  LoveLife
//
//  Created by 杨阳 on 16/6/7.
//  Copyright © 2016年 yangyang. All rights reserved.
//


#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H ([UIScreen mainScreen].bounds.size.height - 64)

#import "GuidePageView.h"
#import "FactoryUI.h"

@interface GuidePageView ()
{
    UIScrollView * _scrollView;
}

@end

@implementation GuidePageView

-(id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray
{
    if (self = [super initWithFrame:frame]) {
        [self createUIWithImageArray:imageArray];
    }
    
    return self;
}

-(void)createUIWithImageArray:(NSArray *)imageArray
{
    //创建scrolLVIew
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H + 64)];
    //设置分页
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
    
    //设置contentSize
    _scrollView.contentSize = CGSizeMake(imageArray.count * _scrollView.frame.size.width, 0);
    
    //创建imageView
    for (int i = 0; i < imageArray.count; i ++) {
        UIImageView * imageView = [FactoryUI createImageViewWithFrame:CGRectMake(i * _scrollView.frame.size.width, 0, SCREEN_W, SCREEN_H + 64) imageName:imageArray[i]];
        //开启用户交互
        //响应者链：UIImageView的用户交互是关闭的，UIView的用户交互默认是开启的，所以涉及到响应的时候，判断的顺序是从子类向父类依次判断
        imageView.userInteractionEnabled = YES;
        
        [_scrollView addSubview:imageView];
        
        if (i == imageArray.count - 1) {
            //创建跳转按钮
            self.goInButton = [FactoryUI createButtonWithFrame:self.bounds title:@"" titleColor:[UIColor blackColor] backgroundColor:nil type:UIButtonTypeCustom target:nil selector:nil];
            [imageView addSubview:self.goInButton];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
