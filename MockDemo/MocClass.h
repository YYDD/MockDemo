//
//  MocClass.h
//  MockDemo
//
//  Created by YYDD on 16/4/9.
//  Copyright © 2016年 com.mock.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MocClass : NSObject


+(void)mocClass:(id)originalObj;

+(void)mocSelector:(SEL)selector ForClass:(id)obj AndReturn:(id)value;

@end
