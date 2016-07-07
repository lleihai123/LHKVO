//
//  ViewController.m
//  LHKVO
//
//  Created by leihai on 16/7/7.
//  Copyright © 2016年 雷海. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+LHKVO.h"
@interface ViewController ()

@end

@implementation LHObservedObject
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    LHObservedObject*object = [LHObservedObject new];
    [object LHaddObserver:@"num" withBlock:^{
        NSLog(@"num");
    }];
    [object LHaddObserver:@"observedNum" withBlock:^{
        NSLog(@"observedNum");
    }];
    [object LHaddObserver:@"printBlock" withBlock:^{
        NSLog(@"printBlock");
    }];
    object.num = 0;
    object.observedNum = @(1);
    object.printBlock = ^(){};
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
