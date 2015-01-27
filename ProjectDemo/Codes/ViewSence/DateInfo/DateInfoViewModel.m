//
//  DateInfoViewModel.m
//  ProjectDemo
//
//  Created by 余河川 on 15/1/27.
//  Copyright (c) 2015年 余河川. All rights reserved.
//

#import "DateInfoViewModel.h"

@interface DateInfoViewModel ()

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation DateInfoViewModel

+ (instancetype)dateInfoModelWithDate:(NSDate *)date {
    DateInfoViewModel *model = [self new];
    if (model) {
        model.date = date;
    }
    return model;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        @weakify(self);
        [self.didBecomeActiveSignal subscribeNext:^(id x) {
            @strongify(self);
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(refreshDateString) userInfo:nil repeats:YES];
        }];
        [self.didBecomeInactiveSignal subscribeNext:^(id x) {
            @strongify(self);
            [self.timer invalidate];
            self.timer = nil;
        }];
    }
    return self;
}

- (void)refreshDateString {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:SS:sss"];
    self.dateString = [NSString stringWithFormat:@"%@\n已过%.3f秒", [formatter stringFromDate:_date], - [_date timeIntervalSinceNow]];
}

- (void)dealloc {
    NSLog(@"date info view model dealloc");
}

@end
