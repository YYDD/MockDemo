//
//  MocClass.m
//  MockDemo
//
//  Created by YYDD on 16/4/9.
//  Copyright © 2016年 com.mock.demo. All rights reserved.
//

#import "MocClass.h"
#import <objc/runtime.h>



@interface MocClass()

@property(nonatomic,strong)NSMutableSet *mocSelNameLists;

@end

@implementation MocClass


+(void)mocClass:(id)originalObj
{    
    object_setClass(originalObj, [MocClass class]);
}

-(NSMutableSet *)mocSelNameLists
{
    if (!_mocSelNameLists) {
        _mocSelNameLists = [[NSMutableSet alloc]init];
    }
    return _mocSelNameLists;
}

+(void)mocSelector:(SEL)selector ForClass:(id)obj AndReturn:(id)value
{
    [obj mockSelector:selector WithReturn:value];
}


-(void)mockSelector:(SEL)selector WithReturn:(id)value
{
    NSString *selectorName = NSStringFromSelector(selector);
    objc_setAssociatedObject(self, objc_unretainedPointer(selectorName) , value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self.mocSelNameLists addObject:selectorName];

}


-(id)getValueInMocMethod:(NSString *)selectorName
{

    return objc_getAssociatedObject(self, objc_unretainedPointer(selectorName));
}



-(void)forwardInvocation:(NSInvocation *)anInvocation
{
    BOOL hasMoc = NO;
    SEL selector = anInvocation.selector;

    NSString *selectorName = NSStringFromSelector(selector);

    for (NSString *mocSelectorName in self.mocSelNameLists) {
        if ([mocSelectorName isEqualToString:selectorName]) {
            anInvocation.selector = @selector(getValueInMocMethod:);
            [anInvocation setArgument:&mocSelectorName atIndex:2];
            [anInvocation invokeWithTarget:self];

            hasMoc = YES;
            break;
        }
    }
    
    if (!hasMoc) {
        [super forwardInvocation:anInvocation];
    }

}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSString *selectorName = NSStringFromSelector(selector);
    if ([self.mocSelNameLists containsObject:selectorName]) {

        return [NSMethodSignature signatureWithObjCTypes:"@@:@"];

    }
  
    return  [super methodSignatureForSelector:selector];
    
}



@end
