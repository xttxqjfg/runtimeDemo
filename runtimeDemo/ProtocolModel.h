//
//  ProtocolModel.h
//  runtimeDemo
//
//  Created by 易博 on 2017/3/20.
//  Copyright © 2017年 yb. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProtocalA <NSObject>

-(void) showA;

@end

@protocol ProtocalB <NSObject>

-(void) showB;

@end

@interface ProtocolModel : NSObject

@end
