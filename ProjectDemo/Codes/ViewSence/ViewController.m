//
//  ViewController.m
//  ProjectDemo
//
//  Created by 余河川 on 15/1/20.
//  Copyright (c) 2015年 余河川. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveViewModel/ReactiveViewModel.h>

@interface ViewController ()

@end

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

@end
