//
//  DateInfoViewModel.h
//  ProjectDemo
//
//  Created by 余河川 on 15/1/27.
//  Copyright (c) 2015年 余河川. All rights reserved.
//

#import "ViewModel.h"

@interface DateInfoViewModel : ViewModel

@property (nonatomic, strong) NSString *dateString;

+ (instancetype)dateInfoModelWithDate:(NSDate *)date;

@end
