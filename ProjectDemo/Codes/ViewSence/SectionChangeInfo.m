//
//  SectionChangeInfo.m
//  ProjectDemo
//
//  Created by 余河川 on 15/1/22.
//  Copyright (c) 2015年 余河川. All rights reserved.
//

#import "SectionChangeInfo.h"
#import <CoreData/CoreData.h>

@interface SectionChangeInfoObject ()

@end

@implementation SectionChangeInfoObject

- (NSMutableIndexSet *)insertSectionsIndexSet {
    if (_insertSectionsIndexSet == nil) {
        _insertSectionsIndexSet = [NSMutableIndexSet indexSet];
    }
    return _insertSectionsIndexSet;
}

- (NSMutableIndexSet *)deleteSectionsIndexSet {
    if (_deleteSectionsIndexSet == nil) {
        _deleteSectionsIndexSet = [NSMutableIndexSet indexSet];
    }
    return _deleteSectionsIndexSet;
}

- (NSMutableArray *)insertObjectsIndexPaths {
    if (_insertObjectsIndexPaths == nil) {
        _insertObjectsIndexPaths = [NSMutableArray array];
    }
    return _insertObjectsIndexPaths;
}

- (NSMutableArray *)deleteObjectsIndexPaths {
    if (_deleteObjectsIndexPaths == nil) {
        _deleteObjectsIndexPaths = [NSMutableArray array];
    }
    return _deleteObjectsIndexPaths;
}

- (NSMutableArray *)updateObjectsIndexPaths {
    if (_updateObjectsIndexPaths == nil) {
        _updateObjectsIndexPaths = [NSMutableArray array];
    }
    return _updateObjectsIndexPaths;
}

- (NSMutableArray *)moveObjectsIndexPaths {
    if (_moveObjectsIndexPaths == nil) {
        _moveObjectsIndexPaths = [NSMutableArray array];
    }
    return _moveObjectsIndexPaths;
}

@end

@interface FetchedResultsControllerDataSourceObject ()

@property (nonatomic, strong) NSFetchedResultsController *resultController;

@end

@implementation FetchedResultsControllerDataSourceObject

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController {
    self = [super init];
    if (self) {
        self.resultController = fetchedResultsController;
    }
    return self;
}

- (NSUInteger)numberOfSectionInfos {
    return [[_resultController sections] count];
}

- (id<SectionInfo>)sectionInfoAtIndex:(NSUInteger)index {
    return [[_resultController sections] objectAtIndex:index];
}

@end











