//
//  ViewController.m
//  runtimeDemo
//
//  Created by 易博 on 2017/3/20.
//  Copyright © 2017年 yb. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"


#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 150, 100, 50)];
    [btn setTitle:@"btn" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 250, 100, 50)];
    [btn1 setTitle:@"btn1" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:btn1];
}

-(void)btnClicked:(UIButton *)sender
{
    NSLog(@"btn clicked...");
}

-(void)runtimeTest
{
    Person *person = [[Person alloc]init];

    unsigned int count;
    NSLog(@"+++++++++++++ 获取属性列表 +++++++++++++");
    objc_property_t *propertyList = class_copyPropertyList([person class], &count);
    for (unsigned int i = 0; i < count; i ++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"属性:%s",propertyName);
    }

    NSLog(@"+++++++++++++ 获取方法列表 +++++++++++++");
    Method *methodList = class_copyMethodList([person class], &count);
    for (unsigned int i = 0; i < count; i ++) {
        SEL methodName = method_getName(methodList[i]);
        NSLog(@"方法:%@",NSStringFromSelector(methodName));
    }

    NSLog(@"+++++++++++++ 获取成员变量列表 +++++++++++++");
    Ivar *ivarList = class_copyIvarList([person class], &count);
    for (unsigned int i = 0; i < count; i ++) {
        const char *ivarName = ivar_getName(ivarList[i]);
        NSLog(@"成员变量:%s",ivarName);

        if(0 == i)
        {
            object_setIvar(person, ivarList[i], @"Han Meimei");
        }
        if(1 == i)
        {
            //此处修改NSInteger类型属性失败，有知道方法的可以评论告诉我
            object_setIvar(person, ivarList[i], @23);
        }
    }
    NSLog(@"动态变量控制:name = %@",person.name);
    NSLog(@"动态变量控制:age = %ld",person.age);

    NSLog(@"+++++++++++++ 获取协议列表 +++++++++++++");
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([person class], &count);
    for (unsigned int i = 0; i < count; i ++) {
        const char *protocolName = protocol_getName(protocolList[i]);
        NSLog(@"协议名:%s",protocolName);
    }

    //通过方法名获得类方法
    Class personClass = object_getClass([Person class]);
    SEL classSel = @selector(testMethod);
    Method classMethod = class_getInstanceMethod(personClass, classSel);

    //通过方法名获得实例方法
    SEL objSel1 = @selector(getName);
    Method objMethod1 = class_getInstanceMethod([person class], objSel1);

    SEL objSel2 = @selector(getAge);
    Method objMethod2 = class_getInstanceMethod([person class], objSel2);

    //交换两个方法的实现
    NSLog(@"交换前-------%@,%ld",[person getName],[person getAge]);
    //由于方法的返回类型不一致，程序运行到此处会失败，这里只是介绍使用方法
    method_exchangeImplementations(objMethod1, objMethod2);
    NSLog(@"交换后-------%@,%ld",[person getName],[person getAge]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
