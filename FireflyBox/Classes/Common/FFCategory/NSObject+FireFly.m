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

- (NSString *)autoDescription:(Class)classType
{
    NSMutableString *propertyMutableStr = [[NSMutableString alloc] init];
    
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(classType, &count);
    for (int i=0; i<count; i++) {
        objc_property_t property = properties[i];
        const char *cPropertyName = property_getName(property);
        NSString *propertyName = [NSString stringWithCString:cPropertyName encoding:NSASCIIStringEncoding];
        if (propertyName) {
            @try {
                id value = [self valueForKey:propertyName];
                [propertyMutableStr appendFormat:@"%@: %@, ", propertyName, value];
            }
            @catch (NSException *exception) {
                [propertyMutableStr appendFormat:@"Can't get value for property %@ through KVO", propertyName];
            }
        }//
    }//for
    
    NSString *tempDescription = nil;
    if (propertyMutableStr.length > 2) {
        tempDescription = [propertyMutableStr substringToIndex:propertyMutableStr.length - 2];
    }
    return tempDescription;
}

- (Class)getCustomClass
{
    return [self class];
}

- (void)log:(Class)classType
{
    // Now see if we need to map any superclasses as well.
    Class superClass = class_getSuperclass(classType);
    if (superClass && [superClass isSubclassOfClass:[NSObject class]]) {
        //
    }
    
    NSString *tempDescription = [self autoDescription:classType];
    FFLog(@"[FFLOG] - (ClassName:%s): %@", class_getName(classType), tempDescription);
}

- (void)log
{
    [self log:[self getCustomClass]];
}

@end
