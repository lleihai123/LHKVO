//
//  ViewController.h
//  LHKVO
//
//  Created by leihai on 16/7/7.
//  Copyright © 2016年 雷海. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

@interface LHObservedObject : NSObject

@property (assign, nonatomic) NSNumber * observedNum;
@property (assign, nonatomic) NSInteger num;
@property (nonatomic, copy) void (^printBlock)();
@end


