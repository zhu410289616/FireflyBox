//
//  NSNull+FireFly.m
//  FireflyBox
//
//  Created by pig on 14-6-5.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "NSNull+FireFly.h"

/**
 *  http://www.cocoachina.com/applenews/devnews/2014/0424/8225.html
 *  https://github.com/yaakaito/Overline/tree/master/Overline/Over/NSNull
 */
@implementation NSNull (FireFly)

//方法1

/*
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL aSelector = [anInvocation selector];
    
    for (NSObject *obj in NSNullObjects) {
        if ([obj respondsToSelector:aSelector]) {
            [anInvocation invokeWithTarget:obj];
            return;
        }
    }
    [self doesNotRecognizeSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        for (NSObject *obj in NSNullObjects) {
            signature = [obj methodSignatureForSelector:aSelector];
            if (signature) {
                break;
            }
        }
    }
    return signature;
}
*/

//方法2

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([self respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:self];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *sig = [[NSNull class] instanceMethodSignatureForSelector:aSelector];
    if (nil == sig) {
        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
    }
    return sig;
}

@end
