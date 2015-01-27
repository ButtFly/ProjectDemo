//
//  DateInfoViewModel.h
//  ProjectDemo
//
//  Created by 余河川 on 15/1/27.
//  Copyright (c) 2015年 余河川. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface DateInfoViewModel : RVMViewModel

@property (nonatomic, strong) NSString *dateString;

+ (instancetype)dateInfoModelWithDate:(NSDate *)date;

@end
