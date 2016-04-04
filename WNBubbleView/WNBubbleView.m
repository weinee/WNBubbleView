//
//  WNBubbleView.m
//  WNBubbleView
//
//  Created by weinee on 16/3/29.
//  Copyright © 2016年 weinee. All rights reserved.
//
#import "WNBubbleView.h"
#import "UIView+SDAutoLayout.h"
#import "WNRectOper.h"

#define TriagleBgSize CGSizeMake(15, 15*(sqrt(3)*0.5))
#define CornerRadius 8

@interface WNBubbleView ()

@property (nonatomic, strong) void (^cb)(NSInteger);
//@property (nonatomic, strong) UIView* coverView;

@property (nonatomic, weak) UIWindow* window;

@property (nonatomic, strong) UIView* btnContent;

@property (nonatomic, strong) UIImageView* triangleBg;

@property (nonatomic, assign) CGPoint anchor;

@end

@implementation WNBubbleView

+(void)showBubbleWithAnchor:(CGPoint)anchor withBtnTitle:(NSArray<NSString *> *)titles animation:(BOOL)animation callBack:(void (^)(NSInteger))cb{
	WNBubbleView *bubbleView = [[WNBubbleView alloc] initBubbleWithAnchor:anchor withBtnTitle:titles callBack:cb];
	bubbleView.animation = animation;
	[bubbleView show];

}



- (instancetype)initBubbleWithAnchor:(CGPoint)anchor withBtnTitle:(NSArray<NSString *> *)titles callBack:(void (^)(NSInteger))cb
{
	self = [super init];
	if (self) {
		//初始化
		self.backgroundColor = [UIColor blackColor];
		self.separatorLineColor = [UIColor whiteColor];
		self.titleColor = [UIColor whiteColor];
		self.bubbleDirect = WNBubbleDirectDown;
		self.animation = YES;
		self.btnSize = CGSizeMake(50, 35);
		
		self.anchor = anchor;
		self.cb = cb;//调用时要判断是否为空
		
		self.frame = self.window.frame;
		//创建遮罩 或者以自身为遮罩
//		UIView *coverView = [[UIView alloc] initWithFrame:self.frame];
//		[self addSubview:coverView];
		
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelf:)];
		[self addGestureRecognizer:tap];
		
		//添加按钮
		for (int i=0; i<titles.count; i++) {
			UIButton* btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
			[btn setTitle:titles[i] forState:UIControlStateNormal];
			[btn setBackgroundImage:[UIImage imageNamed:@"delete_btn"] forState:UIControlStateHighlighted];
			btn.tag = i+1;
			btn.tintColor = self.titleColor;
			btn.backgroundColor = self.backgroundColor;
			[btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
			[self.btnContent addSubview:btn];
		}
		
		//布局和设置样式
		[self doLayout];
	}
	return self;
}

-(void)doLayout{
	//绘制等腰三角形添加到self上, anchor 即为三角形顶点的位置（固定点）
	self.triangleBg.image = [self drawTriangle:TriagleBgSize andColor:self.backgroundColor];
	self.triangleBg.frame = CGRectMake(0, 0, TriagleBgSize.width, TriagleBgSize.height);
	
	//btnContent宽和高
	CGFloat btnWidth = self.btnContent.subviews.count * self.btnSize.width;
	CGFloat btnHeight = self.btnSize.height;
	
	switch (self.bubbleDirect) {
		case WNBubbleDirectDown:
			
			//决定定位三角形
			self.triangleBg.center = CGPointMake(self.anchor.x, self.anchor.y - TriagleBgSize.height * 0.5);
			
			//预布局
			self.btnContent.sd_layout
			.bottomSpaceToView(self.triangleBg, -1)
			.centerXEqualToView(self.triangleBg)
			.heightIs(btnHeight)
			.widthIs(btnWidth);
			[self.btnContent updateLayout];
			
			//根据预布局获取更合适的布局
			CGRect rect = [WNRectOper getFitRectBySup:self.frame subRect:self.btnContent.frame withMargin:5];
			[self.btnContent sd_clearAutoLayoutSettings];
			self.btnContent.frame = rect;
			
			//布局内部按钮, 按钮过多的情况下压缩按钮的宽度
			for (int i=0; i<self.btnContent.subviews.count; i++) {
				self.btnContent.subviews[i].sd_layout
				.leftSpaceToView(i==0 ? self.btnContent : self.btnContent.subviews[i-1], i==0 ? 0 : 0.5)
				.widthRatioToView(self.btnContent, 1.0 / self.btnContent.subviews.count)
				.topEqualToView(self.btnContent)
				.bottomEqualToView(self.btnContent);
			}
			
			
			break;

		default:
			break;
	}
	
	
}

-(void)show{
	[self.window addSubview:self];
}

-(void)remove{
	[self removeFromSuperview];
}

/** 按钮点击*/
-(void)clickBtn:(UIButton *)sender{
	[self remove];
	if (self.cb) {
		self.cb(sender.tag - 1);
	}
}

/** 绘制三角形*/
-(UIImage *)drawTriangle:(CGSize)size andColor:(UIColor *)color{
	UIGraphicsBeginImageContextWithOptions(size, NO, 0);
	[color set];
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextBeginPath(context);
	
	//根据方向绘图
	switch (self.bubbleDirect) {
	  case WNBubbleDirectDown:
		CGContextMoveToPoint(context, 0, 0);
		CGContextAddLineToPoint(context, size.width, 0);
		CGContextAddLineToPoint(context, size.width * 0.5, size.height);
		break;
			
	  default:
			break;
	}
	
	CGContextClosePath(context);
	[color setFill];
	[color setStroke];
	CGContextDrawPath(context, kCGPathFillStroke);
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return img;
}


#pragma mark 手势action
-(void)tapSelf:(UIGestureRecognizer *)gesture{
	//移除
	[self remove];
}

#pragma mark setter
-(void)setBackgroundColor:(UIColor *)backgroundColor{
	_backgroundColor = backgroundColor;
	for (UIButton *btn in self.btnContent.subviews) {
		btn.backgroundColor = backgroundColor;
	}
}

-(void)setTitleColor:(UIColor *)titleColor{
	_titleColor = titleColor;
	for (UIButton *btn in self.btnContent.subviews) {
		btn.tintColor = titleColor;
	}
}

-(void)setSeparatorLineColor:(UIColor *)separatorLineColor{
	_separatorLineColor = separatorLineColor;
	self.btnContent.backgroundColor = separatorLineColor;
}

#pragma mark lazy loading
-(UIView *)btnContent{
	if (_btnContent) {
		return _btnContent;
	}
	_btnContent = [[UIView alloc] init];
	_btnContent.backgroundColor = self.separatorLineColor;
	_btnContent.layer.cornerRadius = CornerRadius;
	_btnContent.layer.masksToBounds = YES;
	[self addSubview:_btnContent];
	return _btnContent;
}

-(UIWindow *)window{
	if (_window) {
		return _window;
	}
	_window = [[[UIApplication sharedApplication] delegate] window];
	return _window;
}

-(UIImageView *)triangleBg{
	if (_triangleBg) {
		return _triangleBg;
	}
	_triangleBg = [[UIImageView alloc] init];
	[self addSubview:_triangleBg];
	return _triangleBg;
}

#pragma mark dealloc
-(void)dealloc{
	_triangleBg = nil;
	_btnContent = nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
