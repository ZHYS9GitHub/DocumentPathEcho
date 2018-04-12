//
//  Person.h
//  DocumentPathEcho
//
//  Created by 老师 on 15/9/14.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <Foundation/Foundation.h>

//必须要遵守归档协议
@interface Person : NSObject<NSCoding>

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *sex;

@end
