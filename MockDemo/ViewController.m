//
//  ViewController.m
//  MockDemo
//
//  Created by YYDD on 16/4/9.
//  Copyright © 2016年 com.mock.demo. All rights reserved.
//

#import "ViewController.h"
#import "MocClass.h"
#import "TestObj.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    TestObj *obj = [TestObj new];
    NSLog(@"%@",obj.testValue);
    [MocClass mocClass:obj];
    [MocClass mocSelector:@selector(testValue) ForClass:obj AndReturn:@"has Mock"];
    NSLog(@"%@",obj.testValue);

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
