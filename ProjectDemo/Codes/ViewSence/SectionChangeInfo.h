//
//  SectionChangeInfo.h
//  ProjectDemo
//
//  Created by 余河川 on 15/1/22.
//  Copyright (c) 2015年 余河川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SectionChangeInfoProtocol.h"

//
//  SectionChangeInfo.h
//  ProjectDemo
//
//  Created by 余河川 on 15/1/22.
//  Copyright (c) 2015年 余河川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SectionChangeInfoProtocol.h"

@interface SectionInfoObject : NSObject <SectionInfo>

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *indexTitle;
@property (nonatomic, assign, readonly) NSUInteger numberOfObjects;
@property (nonatomic, copy, readonly) NSArray *objects;

- (void)setName:(NSString *)name;
- (void)setIndexTitle:(NSString *)indexTitle;
- (void)setNumberOfObjects:(NSUInteger)numberOfObjects;
- (void)setObjects:(NSArray *)objects;
- (void)insertObjectToObjects:(id)anObject atIndex:(NSUInteger)index;
- (void)deleteObjectFromObjectsAtIndex:(NSUInteger)index;
- (void)replaceObjectInObjectsAtIndex:(NSUInteger)index withObject:(id)anObject;

@end

@interface SectionInfoDataSourceObject : NSObject <SectionInfoDataSource>

- (SectionInfoObject *)sectionInfoAtIndex:(NSUInteger)index;
- (NSUInteger)numberOfSectionInfos;

- (void)insertSection:(SectionInfoObject *)anObject atIndex:(NSUInteger)index;
- (void)deleteSectionAtIndex:(NSUInteger)index;
- (void)replaceSectionAtIndex:(NSUInteger)index withObject:(SectionInfoObject *)anObject;

@end


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
