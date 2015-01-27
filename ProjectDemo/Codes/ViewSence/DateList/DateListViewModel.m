//
//  DateListViewModel.m
//  ProjectDemo
//
//  Created by 余河川 on 15/1/20.
//  Copyright (c) 2015年 余河川. All rights reserved.
//

#import "DateListViewModel.h"
#import "DataCenter.h"
#import "SectionChangeInfo.h"

@interface DateListViewModel () <NSFetchedResultsControllerDelegate> {
    SectionChangeInfoObject *p_kCacheInfoObject;
}

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultController;
@property (nonatomic, strong) FetchedResultsControllerDataSourceObject *dataSource;
@property (nonatomic, strong) SectionChangeInfoObject *sectionChangeInfo;

@end

@implementation DateListViewModel

- (void)fetchedResultControllerPerformFetch {
    if (_fetchedResultController == nil) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Date"];
        [request setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]]];
        self.fetchedResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[DataCenter defaultManagedObjectContext] sectionNameKeyPath:@"minute" cacheName:nil];
        self.dataSource = [[FetchedResultsControllerDataSourceObject alloc] initWithFetchedResultsController:_fetchedResultController];
        _fetchedResultController.delegate = self;
        [_fetchedResultController performFetch:nil];
        p_kCacheInfoObject = [SectionChangeInfoObject new];
        p_kCacheInfoObject.type = SectionChangeInitialize;
        self.sectionChangeInfo = p_kCacheInfoObject;
        p_kCacheInfoObject = nil;
    }
}

- (instancetype)init {
    self = [super init];
    if (self) {
        @weakify(self);
        [self.didBecomeActiveSignal subscribeNext:^(id x) {
            @strongify(self);
            [self fetchedResultControllerPerformFetch];
        }];
        [self.didBecomeInactiveSignal subscribeNext:^(id x) {
            @strongify(self);
            self.fetchedResultController = nil;
        }];
    }
    return self;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    p_kCacheInfoObject = [SectionChangeInfoObject new];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    self.sectionChangeInfo = p_kCacheInfoObject;
    p_kCacheInfoObject = nil;
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [p_kCacheInfoObject.insertObjectsIndexPaths insertObject:newIndexPath atIndex:0];
            p_kCacheInfoObject.type |= SectionChangeInsertObjects;
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [p_kCacheInfoObject.deleteObjectsIndexPaths insertObject:indexPath atIndex:0];
            p_kCacheInfoObject.type |= SectionChangeDeleteObjects;
            break;
        }
        case NSFetchedResultsChangeMove: {
            [p_kCacheInfoObject.insertObjectsIndexPaths insertObject:newIndexPath atIndex:0];
            [p_kCacheInfoObject.deleteObjectsIndexPaths insertObject:indexPath atIndex:0];
            p_kCacheInfoObject.type |= SectionChangeInsertObjects;
            p_kCacheInfoObject.type |= SectionChangeDeleteObjects;
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            [p_kCacheInfoObject.updateObjectsIndexPaths insertObject:indexPath atIndex:0];
            p_kCacheInfoObject.type |= SectionChangeUpdateObjects;
            break;
        }
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [p_kCacheInfoObject.insertSectionsIndexSet addIndex:sectionIndex];
            p_kCacheInfoObject.type |= SectionChangeInsertSections;
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [p_kCacheInfoObject.deleteSectionsIndexSet addIndex:sectionIndex];
            p_kCacheInfoObject.type |= SectionChangeDeleteSections;
            break;
        }
        default:
            
            break;
    }
}

- (void)dealloc {
    NSLog(@"date list view model dealloc");
}

@end
