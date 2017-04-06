//
//  UIButton+Count.m
//  runtimeDemo
//
//  Created by 易博 on 2017/3/20.
//  Copyright © 2017年 yb. All rights reserved.
//

#import "UIButton+Count.h"
#import <objc/runtime.h>
#import "ZTools.h"

@implementation UIButton (Count)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class selfClass = [self class];
        
        //原来的方法
        SEL oriSEL = @selector(sendAction:to:forEvent:);
        Method oriMethod = class_getInstanceMethod(selfClass, oriSEL);
        
        //现在的方法
        SEL nowSEL = @selector(addBtnClickCount:to:forEvent:);
        Method nowMethod = class_getInstanceMethod(selfClass, nowSEL);
        
        //给原来的方法添加实现，防止原来的方法没有实现引起奔溃
        BOOL addSupC = class_addMethod(selfClass, oriSEL, method_getImplementation(nowMethod), method_getTypeEncoding(oriMethod));
        if (addSupC) {
            //添加成功，则用现在的方法实现代替原来的方法
            class_replaceMethod(selfClass, nowSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        }else{
            //添加失败,证明原来的方法有实现，直接交换这两个方法
            method_exchangeImplementations(oriMethod, nowMethod);
        }
    });
}

//现在的方法
-(void)addBtnClickCount:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    [[ZTools shareInstance] countClicks];
    [super sendAction:action to:target forEvent:event];
}

@end
