//
//  SectionChangeInfoProtocol.h
//  ProjectDemo
//
//  Created by 余河川 on 15/1/22.
//  Copyright (c) 2015年 余河川. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, SectionChangeType) {
    SectionChangeInsertSections     = 1 << 0,
    SectionChangeDeleteSections     = 1 << 1,
    SectionChangeInsertObjects      = 1 << 2,
    SectionChangeDeleteObjects      = 1 << 3,
    SectionChangeMoveObjects        = 1 << 4,
    SectionChangeUpdateObjects      = 1 << 5,
    SectionChangeInitialize         = NSNotFound
};

@protocol SectionInfo <NSObject>

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *indexTitle;
@property (nonatomic, assign, readonly) NSUInteger numberOfObjects;
@property (nonatomic, copy, readonly) NSArray *objects;

@end

@protocol SectionInfoDataSource <NSObject>

- (id<SectionInfo>)sectionInfoAtIndex:(NSUInteger)index;
- (NSUInteger)numberOfSectionInfos;

@end

@protocol SectionChangeInfo <NSObject>

@property (nonatomic, assign, readonly) SectionChangeType type;
@property (nonatomic, copy, readonly) NSIndexSet *insertSectionsIndexSet;
@property (nonatomic, copy, readonly) NSIndexSet *deleteSectionsIndexSet;
@property (nonatomic, copy, readonly) NSArray *insertObjectsIndexPaths;
@property (nonatomic, copy, readonly) NSArray *deleteObjectsIndexPaths;
@property (nonatomic, copy, readonly) NSArray *moveObjectsIndexPaths;
@property (nonatomic, copy, readonly) NSArray *updateObjectsIndexPaths;

@end
