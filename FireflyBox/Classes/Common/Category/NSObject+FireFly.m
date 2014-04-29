//
//  NSObject+FireFly.m
//  FireflyBox
//
//  Created by pig on 14-4-29.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "NSObject+FireFly.h"
#import <objc/runtime.h>

@implementation NSObject (FireFly)

- (void)log
{
    id LenderClass= objc_getClass("ClassName");
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList(LenderClass, &outCount);
    for (int i=0; i<outCount; i++) {
        objc_property_t property = properties[i];
        fprintf(stdout, "%s %s\n", property_getName(property), property_getAttributes(property));
    }
}

@end
