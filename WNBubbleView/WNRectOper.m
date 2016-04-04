//
//  WNRectOper.m
//  WNBubbleView
//
//  Created by weinee on 16/4/3.
//  Copyright © 2016年 weinee. All rights reserved.
//

#import "WNRectOper.h"

@implementation WNRectOper

+(WNRectRel)getRelReferRect:(CGRect)referRect rect:(CGRect)secondRect{
	WNRectRel rel = WNRectRelInclude;
	if ((CGRectGetMinX(referRect) <= CGRectGetMinX(secondRect) && CGRectGetMinY(referRect) <= CGRectGetMinY(secondRect)) && (CGRectGetMaxX(referRect) >= CGRectGetMaxX(secondRect) && CGRectGetMaxY(referRect) >= CGRectGetMaxY(secondRect))) {
		return rel;
	}
	if (CGRectIntersectsRect(referRect, secondRect)) {
		rel += WNRectRelIntersection;
	}
	//判断位置情况，   根据范围进行判断
	if (CGRectGetMinY(referRect) > CGRectGetMinY(secondRect)) {
		rel += WNRectRelTop;
	}
	if (CGRectGetMinX(referRect) > CGRectGetMinX(secondRect)) {
		rel += WNRectRelLeft;
	}
	if (CGRectGetMaxY(referRect) < CGRectGetMaxY(secondRect)) {
		rel += WNRectRelBottom;
	}
	if (CGRectGetMaxX(referRect) < CGRectGetMaxX(secondRect)) {
		rel += WNRectRelRight;
	}
	return rel;
}

+(CGRect)getFitRectBySup:(CGRect)supRect subRect:(CGRect)subRect withMargin:(CGFloat)margin{
	if (CGRectGetWidth(supRect) < CGRectGetWidth(subRect) - 2*margin) {
		subRect.size.width = supRect.size.width - 2*margin;
	}
	if (CGRectGetHeight(supRect) < CGRectGetHeight(subRect) - 2*margin) {
		subRect.size.height = supRect.size.height - 2*margin;
	}
	WNRectRel rel = [self getRelReferRect:supRect rect:subRect];
	if (rel == WNRectRelInclude) {
		return subRect;
	}
	if (rel & WNRectRelTop) {
		subRect.origin.y = supRect.origin.y + margin;
	}
	if (rel & WNRectRelLeft) {
		subRect.origin.x = supRect.origin.x + margin;
	}
	if (rel & WNRectRelBottom) {
		subRect.origin.y -= (CGRectGetMaxY(subRect) - CGRectGetMaxY(supRect) + margin);
	}
	if (rel & WNRectRelRight) {
		subRect.origin.x -= (CGRectGetMaxX(subRect) - CGRectGetMaxX(supRect) + margin);
	}
	return subRect;
}
@end
