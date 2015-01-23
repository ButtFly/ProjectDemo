//
//  DateListViewController.m
//  ProjectDemo
//
//  Created by 余河川 on 15/1/20.
//  Copyright (c) 2015年 余河川. All rights reserved.
//

#import "DateListViewController.h"
#import "DateListViewModel.h"

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
        NSLog(@"----------------------------------------------------");
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
    NSLog(@"section:%ld", [self.viewModel.dataSource numberOfSectionInfos]);
    return [self.viewModel.dataSource numberOfSectionInfos];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"rows:%ld", [[[self.viewModel.dataSource sectionInfoAtIndex:section] objects] count]);
    return [[[self.viewModel.dataSource sectionInfoAtIndex:section] objects] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSDate *date = [[[[self.viewModel.dataSource sectionInfoAtIndex:indexPath.section] objects] objectAtIndex:indexPath.row] valueForKeyPath:@"date"];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    cell.textLabel.text = [formatter stringFromDate:date];
    return cell;
}

@end









