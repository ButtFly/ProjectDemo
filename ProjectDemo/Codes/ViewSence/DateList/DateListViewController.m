//
//  DateListViewController.m
//  ProjectDemo
//
//  Created by 余河川 on 15/1/20.
//  Copyright (c) 2015年 余河川. All rights reserved.
//

#import "DateListViewController.h"
#import "DateListViewModel.h"
#import <MGSwipeTableCell/MGSwipeTableCell.h>
#import <MGSwipeTableCell/MGSwipeButton.h>
#import "DataCenter.h"

@interface DateListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) DateListViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation DateListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewModel = [DateListViewModel new];
    @weakify(self);
    [RACObserve(self.viewModel, sectionChangeInfo) subscribeNext:^(id<SectionChangeInfo> sectionChangeInfo) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([sectionChangeInfo type] == SectionChangeInitialize) {
                [self.table reloadData];
            } else {
                [self.table beginUpdates];
                if (sectionChangeInfo.type & SectionChangeInsertSections) {
                    [self.table insertSections:[sectionChangeInfo insertSectionsIndexSet] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
                if ([sectionChangeInfo type] & SectionChangeInsertObjects) {
                    [self.table insertRowsAtIndexPaths:[sectionChangeInfo insertObjectsIndexPaths] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
                if ([sectionChangeInfo type] & SectionChangeDeleteSections) {
                    [self.table deleteSections:[sectionChangeInfo deleteSectionsIndexSet] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
                if ([sectionChangeInfo type] & SectionChangeDeleteObjects) {
                    [self.table deleteRowsAtIndexPaths:[sectionChangeInfo deleteObjectsIndexPaths] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
                if ([sectionChangeInfo type] & SectionChangeUpdateObjects) {
                    [self.table reloadRowsAtIndexPaths:[sectionChangeInfo updateObjectsIndexPaths] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
                [self.table endUpdates];
            }
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)viewController {
    DateListViewController *vc = [[UIStoryboard storyboardWithName:@"DateList" bundle:nil] instantiateInitialViewController];
    return vc;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel.dataSource numberOfSectionInfos];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self.viewModel.dataSource sectionInfoAtIndex:section] objects] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MGSwipeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSManagedObject *obj = [[[self.viewModel.dataSource sectionInfoAtIndex:indexPath.section] objects] objectAtIndex:indexPath.row];
    NSDate *date = [obj valueForKeyPath:@"date"];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    cell.textLabel.text = [formatter stringFromDate:date];
    MGSwipeButton *button1 = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor redColor] callback:^BOOL(MGSwipeTableCell *sender) {
        [[DataCenter defaultManagedObjectContext] deleteObject:obj];
        return YES;
    }];
    MGSwipeButton *button2 = [MGSwipeButton buttonWithTitle:@"更新" backgroundColor:[UIColor greenColor] callback:^BOOL(MGSwipeTableCell *sender) {
        [obj setValue:[NSDate date] forKeyPath:@"date"];
        return YES;
    }];
    [cell setRightButtons:@[button1, button2]];
    return cell;
}

- (IBAction)addDateAction:(UIBarButtonItem *)sender {
    NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:@"Date" inManagedObjectContext:[DataCenter defaultManagedObjectContext]];
    [obj setValue:[NSDate date] forKeyPath:@"date"];
}

@end









