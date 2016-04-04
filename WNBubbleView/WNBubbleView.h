//
//  WNBubbleView.h
//  WNBubbleView
//
//  Created by weinee on 16/3/29.
//  Copyright © 2016年 weinee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	WNBubbleDirectUp, WNBubbleDirectDown, WNBubbleDirectLeft, WNBubbleDirectRigth
} WNBubbleDirect;

@interface WNBubbleView : UIView
//单个按钮的大小
@property (nonatomic, assign) CGSize btnSize;
//是否使用动画显示
@property (nonatomic, assign) BOOL animation;
//菜单展开方向，枚举, 箭头的方向
@property (nonatomic, assign) WNBubbleDirect bubbleDirect;
//样式
@property (nonatomic, strong) UIColor* backgroundColor;
@property (nonatomic, strong) UIColor* separatorLineColor;
@property (nonatomic, strong) UIColor* titleColor;


//快捷显示气泡
+(void)showBubbleWithAnchor:(CGPoint) anchor
			   withBtnTitle:(NSArray<NSString*> *) titles
				  animation:(BOOL) animation
				   callBack:(void(^)(NSInteger)) cb;
//快捷显示气泡， view为点击的view
+(void)showBubbleWithView:(UIView *) view
			   withBtnTitle:(NSArray<NSString*> *) titles
				  animation:(BOOL) animation
				   callBack:(void(^)(NSInteger)) cb;
+(void)showBubbleWithAnchor:(CGPoint) anchor
			   withBtnImage:(NSArray<NSString*> *) titles
				  animation:(BOOL) annimation
				   callBack:(void(^)(NSInteger)) cb;

-(instancetype)initBubbleWithAnchor:(CGPoint) anchor
			   withBtnTitle:(NSArray<NSString*> *) titles
						   callBack:(void(^)(NSInteger)) cb;
-(instancetype)initBubbleWithAnchor:(CGPoint) anchor
					   withBtnImage:(NSArray<NSString*> *) titles
						   callBack:(void(^)(NSInteger)) cb;
//显示
-(void)show;

//移除
-(void)remove;
@end
