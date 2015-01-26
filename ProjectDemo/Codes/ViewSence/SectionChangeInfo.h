//
//  SectionChangeInfo.h
//  ProjectDemo
//
//  Created by 余河川 on 15/1/22.
//  Copyright (c) 2015年 余河川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SectionChangeInfoProtocol.h"

@interface SectionChangeInfoObject : NSObject <SectionChangeInfo>

@property (nonatomic, assign) SectionChangeType type;
@property (nonatomic, copy) NSMutableIndexSet *insertSectionsIndexSet;
@property (nonatomic, copy) NSMutableIndexSet *deleteSectionsIndexSet;
@property (nonatomic, copy) NSMutableArray *insertObjectsIndexPaths;
@property (nonatomic, copy) NSMutableArray *deleteObjectsIndexPaths;
@property (nonatomic, copy) NSMutableArray *moveObjectsIndexPaths;
@property (nonatomic, copy) NSMutableArray *updateObjectsIndexPaths;

@end

@class NSFetchedResultsController;
@interface FetchedResultsControllerDataSourceObject : NSObject <SectionInfoDataSource>

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController;

- (id<SectionInfo>)sectionInfoAtIndex:(NSUInteger)index;
- (NSUInteger)numberOfSectionInfos;

@end
