//
//  SectionChangeInfo.m
//  ProjectDemo
//
//  Created by 余河川 on 15/1/22.
//  Copyright (c) 2015年 余河川. All rights reserved.
//

#import "SectionChangeInfo.h"
#import <CoreData/CoreData.h>

@interface SectionInfoObject ()

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *indexTitle;
@property (nonatomic, assign) NSUInteger numberOfObjects;
@property (nonatomic, copy) NSMutableArray *objects;

@end

@implementation SectionInfoObject
@synthesize objects = _objects;

- (void)setObjects:(NSArray *)objects {
    _objects = [objects mutableCopy];
}

- (NSArray *)objects {
    return [_objects copy];
}

- (void)insertObjectToObjects:(id)anObject atIndex:(NSUInteger)index {
    [(NSMutableArray *)_objects insertObject:anObject atIndex:index];
}
- (void)deleteObjectFromObjectsAtIndex:(NSUInteger)index {
    [(NSMutableArray *)_objects removeObjectAtIndex:index];
}
- (void)replaceObjectInObjectsAtIndex:(NSUInteger)index withObject:(id)anObject {
    [(NSMutableArray *)_objects replaceObjectAtIndex:index withObject:anObject];
}

@end

@interface SectionInfoDataSourceObject ()

@property (nonatomic, strong) NSMutableArray *sections;

@end

@implementation SectionInfoDataSourceObject

- (instancetype)init {
    self = [super init];
    if (self) {
        self.sections = [NSMutableArray array];
    }
    return self;
}

- (NSUInteger)numberOfSectionInfos {
    return [_sections count];
}

- (SectionInfoObject *)sectionInfoAtIndex:(NSUInteger)index {
    return [_sections objectAtIndex:index];
}

- (void)insertSection:(SectionInfoObject *)anObject atIndex:(NSUInteger)index {
    [_sections insertObject:anObject atIndex:index];
}

- (void)deleteSectionAtIndex:(NSUInteger)index {
    [_sections removeObjectAtIndex:index];
}

- (void)replaceSectionAtIndex:(NSUInteger)index withObject:(SectionInfoObject *)anObject {
    [_sections replaceObjectAtIndex:index withObject:anObject];
}

@end

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











