//
//  Person.m
//  DocumentPathEcho
//
//  Created by 老师 on 15/9/14.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "Person.h"

@implementation Person
//把所有属性全部归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.sex = [aDecoder decodeObjectForKey:@"sexde"];
    }
    return self;
}

@end
