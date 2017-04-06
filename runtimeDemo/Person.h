//
//  Person.h
//  runtimeDemo
//
//  Created by 易博 on 2017/3/20.
//  Copyright © 2017年 yb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProtocolModel.h"

@interface Person : NSObject<ProtocalA,ProtocalB>

@property (nonatomic,strong) NSString *name;

@property (nonatomic,assign) NSInteger age;

-(NSString *) getName;

-(NSInteger) getAge;

+(void) testMethod;

@end
