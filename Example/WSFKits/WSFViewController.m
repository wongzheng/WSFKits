//
//  WSFViewController.m
//  WSFKits
//
//  Created by zbad1171@qq.com on 04/08/2019.
//  Copyright (c) 2019 zbad1171@qq.com. All rights reserved.
//

#import "WSFViewController.h"
//#import <WSFKits/>
#import <objc/message.h>

@interface WSFViewController ()

@end

@implementation WSFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSObject *obj = [NSObject new];
    objc_msgSend(obj,NSSelectorFromString(@"abc"));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
