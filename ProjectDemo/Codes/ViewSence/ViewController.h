//
//  ViewController.h
//  ProjectDemo
//
//  Created by 余河川 on 15/1/20.
//  Copyright (c) 2015年 余河川. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

@class RVMViewModel;
@interface ViewController : UIViewController

@property (nonatomic, strong) RVMViewModel *viewModel;

@end

typedef NS_OPTIONS(NSInteger, ScreenSizeOptions){
    ScreenSizeW320_H480 = 1 << 0,
    ScreenSizeW320_H568 = 1 << 1,
    ScreenSizeW375_H667 = 1 << 2,
    ScreenSizeW414_H736 = 1 << 3,
    ScreenSizeDefault = ScreenSizeW320_H480 | ScreenSizeW320_H568 | ScreenSizeW375_H667 | ScreenSizeW414_H736
};

@interface ViewController (ContentsFit)

- (void)needFitScreenSizeWithContents:(NSArray *)contents andValues:(NSArray *)values screenSizeOptions:(ScreenSizeOptions)size;
- (id)specialConstantWithIdentifier:(NSString *)identifier;

@end

