//
//  ViewController.m
//  WNBubbleView
//
//  Created by weinee on 16/3/29.
//  Copyright © 2016年 weinee. All rights reserved.
//

#import "ViewController.h"
#import "WNBubbleView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	btn.backgroundColor = [UIColor redColor];
	btn.frame = CGRectMake(200, 300, 100, 100);
	[self.view addSubview:btn];
	[btn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTrigger:)];
	[self.view addGestureRecognizer:tap];
}

-(void)test:(UIButton*) sender{
	
	CGPoint center = [sender.superview convertPoint:sender.center toView:nil];
	[WNBubbleView showBubbleWithAnchor:center withBtnTitle:@[@"we", @"we2", @"sdf3", @"sfs4", @"we", @"we2", @"sdf3", @"sfs4"] animation:YES callBack:^(NSInteger index) {
		NSLog(@"%ld", index);
	}];
	
}

-(void)tapTrigger:(UIGestureRecognizer *) sender{
	CGPoint center = [sender locationInView:nil];
	[WNBubbleView showBubbleWithAnchor:center withBtnTitle:@[@"we", @"we2", @"sdf3", @"sfs4"] animation:YES callBack:^(NSInteger index) {
		NSLog(@"%ld", index);
	}];
}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
