//
//  DateListViewModel.h
//  ProjectDemo
//
//  Created by 余河川 on 15/1/20.
//  Copyright (c) 2015年 余河川. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SectionChangeInfoProtocol.h"

@interface DateListViewModel : RVMViewModel

@property (nonatomic, strong, readonly) id<SectionChangeInfo> sectionChangeInfo;
@property (nonatomic, strong, readonly) id<SectionInfoDataSource> dataSource;

@end
