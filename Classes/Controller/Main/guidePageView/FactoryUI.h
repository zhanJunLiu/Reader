//
//  FactoryUI.h
//  LoveLife
//
//  Created by 杨阳 on 16/6/6.
//  Copyright © 2016年 yangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FactoryUI : NSObject

/*
在iOS中，常用的设计模式有MVC，单例，KVO，工厂，策略
 KVC表示的是属性赋值的方式，他并不是设计模式
 工厂：指的是大批量生产零件的地方，在iOS中，工厂设计模式表示我们可以将一类控件提出来（使用静态方法），方便后期统一修改
 
 策略：同一个问题可以有多个解决办法，我们可以将这多个解决办法单独封装成不同的方法，在使用的时候根据自己的需要选用合适的方法，选择其中一种方法，对其他的方法是没有影响的，我们把这个过程就成为策略设计模式
 */

//定义工厂类，将常用的控件涉及到的属性用静态方法做一归纳总结，方便统一修改
//UIView
+ (UIView *)createViewWithFrame:(CGRect)frame;
//UILabel
+ (UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;
//UIButton
+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor type:(UIButtonType)type target:(id)target  selector:(SEL)selector;
//UIImageView
+ (UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName;
//UITextField
+ (UITextField *)createTextFieldWithFrame:(CGRect)frame text:(NSString *)text placeholder:(NSString *)placeholder;













@end
