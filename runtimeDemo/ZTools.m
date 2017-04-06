//
//  ZTools.m
//  runtimeDemo
//
//  Created by 易博 on 2017/3/20.
//  Copyright © 2017年 yb. All rights reserved.
//

#import "ZTools.h"

@implementation ZTools

static id _instance;

+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[ZTools alloc] init];
    });
    return _instance;
}

-(void)countClicks
{
    _count += 1;
    NSLog(@"点击次数:%ld",_count);
}

@end
