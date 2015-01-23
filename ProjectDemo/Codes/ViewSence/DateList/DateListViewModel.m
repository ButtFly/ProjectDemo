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
@property (nonatomic, strong) SectionInfoDataSourceObject *dataSource;
@property (nonatomic, strong) SectionChangeInfoObject *sectionChangeInfo;

@end

@implementation DateListViewModel

- (void)fetchedResultControllerPerformFetch {
    if (_fetchedResultController == nil) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Date"];
        [request setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]]];
        self.fetchedResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[DataCenter defaultManagedObjectContext] sectionNameKeyPath:nil cacheName:nil];
        _fetchedResultController.delegate = self;
        [_fetchedResultController performFetch:nil];
        [[_fetchedResultController sections] enumerateObjectsUsingBlock:^(id<NSFetchedResultsSectionInfo> sectionInfo, NSUInteger idx, BOOL *stop) {
            SectionInfoObject *section = [SectionInfoObject new];
            section.name = [sectionInfo name];
            section.indexTitle = [sectionInfo indexTitle];
            section.numberOfObjects = [sectionInfo numberOfObjects];
            section.objects = [sectionInfo objects];
            [(SectionInfoDataSourceObject *)_dataSource insertSection:section atIndex:idx];
            [[p_kCacheInfoObject insertSectionsIndexSet] addIndex:idx];
            p_kCacheInfoObject.type = SectionChangeInitialize;
        }];
        if (p_kCacheInfoObject.type != 0) {
            self.sectionChangeInfo = p_kCacheInfoObject;
        }
        p_kCacheInfoObject = nil;
    }
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self.didBecomeActiveSignal subscribeNext:^(id x) {
            [self fetchedResultControllerPerformFetch];
        }];
        [self.didBecomeInactiveSignal subscribeNext:^(id x) {
            self.fetchedResultController = nil;
        }];
        self.dataSource = [SectionInfoDataSourceObject new];
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
            SectionInfoObject *sectionInfo = [(SectionInfoDataSourceObject *)_dataSource sectionInfoAtIndex:newIndexPath.section];
            [sectionInfo insertObjectToObjects:anObject atIndex:newIndexPath.row];
            [p_kCacheInfoObject.insertObjectsIndexPaths insertObject:newIndexPath atIndex:0];
            p_kCacheInfoObject.type |= SectionChangeInsertObjects;
            break;
        }
        case NSFetchedResultsChangeDelete: {
            SectionInfoObject *sectionInfo = [(SectionInfoDataSourceObject *)_dataSource sectionInfoAtIndex:indexPath.section];
            [sectionInfo deleteObjectFromObjectsAtIndex:indexPath.row];
            [p_kCacheInfoObject.deleteObjectsIndexPaths insertObject:indexPath atIndex:0];
            p_kCacheInfoObject.type |= SectionChangeDeleteObjects;
            break;
        }
        case NSFetchedResultsChangeMove: {
            SectionInfoObject *sectionInfo = [(SectionInfoDataSourceObject *)_dataSource sectionInfoAtIndex:indexPath.section];
            [sectionInfo deleteObjectFromObjectsAtIndex:indexPath.row];
            SectionInfoObject *newSectionInfo = [(SectionInfoDataSourceObject *)_dataSource sectionInfoAtIndex:newIndexPath.section];
            [newSectionInfo insertObjectToObjects:anObject atIndex:newIndexPath.row];
            [p_kCacheInfoObject.insertObjectsIndexPaths insertObject:newIndexPath atIndex:0];
            [p_kCacheInfoObject.deleteObjectsIndexPaths insertObject:indexPath atIndex:0];
            p_kCacheInfoObject.type |= SectionChangeInsertObjects;
            p_kCacheInfoObject.type |= SectionChangeDeleteObjects;
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            SectionInfoObject *sectionInfo = [(SectionInfoDataSourceObject *)_dataSource sectionInfoAtIndex:indexPath.section];
            [sectionInfo replaceObjectInObjectsAtIndex:indexPath.row withObject:anObject];
            [p_kCacheInfoObject.updateObjectsIndexPaths insertObject:indexPath atIndex:0];
            p_kCacheInfoObject.type |= SectionChangeUpdateObjects;
            break;
        }
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            SectionInfoObject *section = [SectionInfoObject new];
            section.name = [sectionInfo name];
            section.indexTitle = [sectionInfo indexTitle];
            section.numberOfObjects = [sectionInfo numberOfObjects];
            section.objects = [sectionInfo objects];
            [(SectionInfoDataSourceObject *)_dataSource insertSection:section atIndex:sectionIndex];
            [p_kCacheInfoObject.insertSectionsIndexSet addIndex:sectionIndex];
            p_kCacheInfoObject.type |= SectionChangeInsertSections;
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [(SectionInfoDataSourceObject *)_dataSource deleteSectionAtIndex:sectionIndex];
            p_kCacheInfoObject.type |= SectionChangeDeleteSections;
            break;
        }
        default:
            
            break;
    }
}

@end
