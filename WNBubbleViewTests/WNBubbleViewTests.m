//
//  WNBubbleViewTests.m
//  WNBubbleViewTests
//
//  Created by weinee on 16/3/29.
//  Copyright © 2016年 weinee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WNRectOper.h"


@interface WNBubbleViewTests : XCTestCase

@end

@implementation WNBubbleViewTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
	//包含
	XCTAssertEqual([WNRectOper getRelReferRect:CGRectMake(100, 100, 100, 100) rect:CGRectMake(100, 100, 100, 100)], WNRectRelInclude);
	XCTAssertEqual([WNRectOper getRelReferRect:CGRectMake(100, 100, 100, 100) rect:CGRectMake(100, 100, 20, 90)], WNRectRelInclude);
	XCTAssertEqual([WNRectOper getRelReferRect:CGRectMake(100, 100, 100, 100) rect:CGRectMake(110, 101, 30, 50)], WNRectRelInclude);
	
	//相交 顶部和右部相交
	XCTAssertEqual([WNRectOper getRelReferRect:CGRectMake(100, 100, 100, 200) rect:CGRectMake(150, 90, 100, 100)], WNRectRelRight + WNRectRelTop +WNRectRelIntersection);
	XCTAssertTrue([WNRectOper getRelReferRect:CGRectMake(100, 100, 100, 200) rect:CGRectMake(150, 90, 100, 100)] & WNRectRelRight);
	XCTAssertTrue([WNRectOper getRelReferRect:CGRectMake(100, 100, 100, 200) rect:CGRectMake(150, 90, 100, 100)] & WNRectRelTop);
	
	// 左部和下部相交
	XCTAssertEqual([WNRectOper getRelReferRect:CGRectMake(100, 100, 100, 200) rect:CGRectMake(50, 250, 100, 100)], WNRectRelLeft + WNRectRelBottom +WNRectRelIntersection);
	
	// 左部和右部
	XCTAssertEqual([WNRectOper getRelReferRect:CGRectMake(100, 100, 100, 200) rect:CGRectMake(50, 150, 200, 100)], WNRectRelLeft + WNRectRelRight +WNRectRelIntersection);
	
	//右部
	XCTAssertTrue([WNRectOper getRelReferRect:CGRectMake(100, 100, 100, 200) rect:CGRectMake(150, 150, 100, 100)] & WNRectRelRight + WNRectRelIntersection);
	XCTAssertEqual([WNRectOper getRelReferRect:CGRectMake(100, 100, 100, 200) rect:CGRectMake(150, 150, 100, 100)],  WNRectRelRight + WNRectRelIntersection);
	
	//上下左右 , refer包含于secondRect
	XCTAssertEqual([WNRectOper getRelReferRect:CGRectMake(100, 100, 100, 200) rect:CGRectMake(50, 50, 500, 500)], WNRectRelLeft + WNRectRelRight + WNRectRelTop + WNRectRelBottom + WNRectRelIntersection);
	
	//测试获取合适的矩形
	XCTAssertTrue(CGRectEqualToRect(CGRectMake(100, 100, 100, 200), [WNRectOper getFitRectBySup:CGRectMake(100, 100, 100, 200) subRect:CGRectMake(50, 50, 500, 500)withMargin:0]));
	XCTAssertTrue(CGRectEqualToRect(CGRectMake(100, 150, 100, 100), [WNRectOper getFitRectBySup:CGRectMake(100, 100, 100, 200) subRect:CGRectMake(150, 150, 100, 100)withMargin:0]));
	XCTAssertTrue(CGRectEqualToRect(CGRectMake(100, 200, 100, 100), [WNRectOper getFitRectBySup:CGRectMake(100, 100, 100, 200) subRect:CGRectMake(50, 250, 100, 100)withMargin:0]));
	//top
	XCTAssertTrue(CGRectEqualToRect(CGRectMake(150, 100, 50, 200), [WNRectOper getFitRectBySup:CGRectMake(100, 100, 100, 200) subRect:CGRectMake(150, 50, 50, 500)withMargin:0]));
	
//	[WNRectOper getFitRectBySup:CGRectMake(100, 100, 100, 200) subRect:CGRectMake(150, 50, 50, 500)withMargin:0];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
