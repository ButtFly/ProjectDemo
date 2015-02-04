//
//  ViewController.m
//  ProjectDemo
//
//  Created by 余河川 on 15/1/20.
//  Copyright (c) 2015年 余河川. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveViewModel/ReactiveViewModel.h>

@interface ViewController () {
    NSMutableDictionary *p_kSpecialConstants;
}

@end

static CGSize ScreenSizeW_320_H_480() {
    return CGSizeMake(320, 480);
}

static CGSize ScreenSizeW_320_H_568() {
    return CGSizeMake(320, 568);
}

static CGSize ScreenSizeW_375_H_667() {
    return CGSizeMake(375, 667);
}

static CGSize ScreenSizeW_414_H_736() {
    return CGSizeMake(414, 736);
}

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_viewModel setActive:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_viewModel setActive:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - contents fit

- (NSMutableDictionary *)specialConstants {
    if (p_kSpecialConstants == nil) {
        p_kSpecialConstants = [NSMutableDictionary dictionary];
    }
    return p_kSpecialConstants;
}

- (id)specialConstantWithIdentifier:(NSString *)identifier {
    return [[self specialConstants] objectForKey:identifier];
}

- (BOOL)isCurrentScreenSizeMatch:(ScreenSizeOptions)option {
    BOOL result = NO;
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (ScreenSizeW320_H480 & option) {
        result |= CGSizeEqualToSize(ScreenSizeW_320_H_480(), screenSize);
    }
    if (!result && ScreenSizeW320_H568 & option) {
        result |= CGSizeEqualToSize(ScreenSizeW_320_H_568(), screenSize);
    }
    if (!result && ScreenSizeW375_H667 & option) {
        result |= CGSizeEqualToSize(ScreenSizeW_375_H_667(), screenSize);
    }
    if (!result && ScreenSizeW414_H736 & option) {
        result |= CGSizeEqualToSize(ScreenSizeW_414_H_736(), screenSize);
    }
    return result;
}

- (void)needFitScreenSizeWithContents:(NSArray *)contents andValues:(NSArray *)values screenSizeOptions:(ScreenSizeOptions)size {
    if (![self isCurrentScreenSizeMatch:size]) return;
    [contents enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIView class]]) {
            [obj setValue:values[idx] forKey:@"font"];
        } else if ([obj isKindOfClass:[NSLayoutConstraint class]]) {
            [obj setConstant:[values[idx] floatValue]];
        } else if ([obj isKindOfClass:[NSString class]]) {
            [[self specialConstants] setObject:values[idx] forKey:obj];
        }
    }];
}

@end










