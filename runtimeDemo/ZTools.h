//
//  ZTools.h
//  runtimeDemo
//
//  Created by 易博 on 2017/3/20.
//  Copyright © 2017年 yb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTools : NSObject

@property (nonatomic,assign) NSInteger count;

+(instancetype)shareInstance;

-(void)countClicks;

@end
