//
//  WNRectOper.h
//  WNBubbleView
//
//  Created by weinee on 16/4/3.
//  Copyright © 2016年 weinee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum WNRectRel{//矩形关系， 相对于参照矩形而言的关系, 不包含不相离即相交
	WNRectRelInclude = 0,//包含于参照矩形
	WNRectRelIntersection = 1,//相交
	WNRectRelTop = 1 << 1,
	WNRectRelLeft = 1 << 2,
	WNRectRelBottom = 1 << 3,
	WNRectRelRight = 1 << 4,
}WNRectRel;

@interface WNRectOper : NSObject
/**
 *  将子矩形放入父矩形
 *
 *  @param supRect 父矩形
 *  @param subRect 子矩形
 *
 *  @return 将子矩形变换为父矩形内部的矩形
 */
+(CGRect) getFitRectBySup:(CGRect) supRect subRect:(CGRect) subRect withMargin:(CGFloat) margin;

/**
 *  获取两个矩形的关系
 *
 *  @param referRect  参照矩形
 *  @param secondRect 相对矩形
 *
 *  @return 关系枚举值, 通过枚举类型值计算得到的
 */
+(WNRectRel) getRelReferRect:(CGRect) referRect rect:(CGRect) secondRect;

@end
