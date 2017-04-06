//
//  Person.m
//  runtimeDemo
//
//  Created by 易博 on 2017/3/20.
//  Copyright © 2017年 yb. All rights reserved.
//

#import "Person.h"

@implementation Person

-(NSString *) getName{
    return @"I am Lilei";
}

-(NSInteger) getAge{
    return 25;
}

+(void) testMethod{
    NSLog(@"This is a test class method");
}

-(NSString *)personDescribe
{
    return [NSString stringWithFormat:@"name=%@,age=%ld",_name,_age];
}

@end
