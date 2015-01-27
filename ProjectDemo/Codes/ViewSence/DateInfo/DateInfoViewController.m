//
//  DateInfoViewController.m
//  ProjectDemo
//
//  Created by 余河川 on 15/1/27.
//  Copyright (c) 2015年 余河川. All rights reserved.
//

#import "DateInfoViewController.h"
#import "DateInfoViewModel.h"

@interface DateInfoViewController ()

@property (nonatomic, strong) DateInfoViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation DateInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    RAC(_label, text) = RACObserve(self.viewModel, dateString);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

+ (instancetype)viewControllerWithDate:(NSDate *)date {
    DateInfoViewController *vc = [[UIStoryboard storyboardWithName:@"DateList" bundle:nil] instantiateViewControllerWithIdentifier:@"date_info_view_controller"];
    vc.viewModel = [DateInfoViewModel dateInfoModelWithDate:date];
    return vc;
}

- (void)dealloc {
    NSLog(@"date info view controller dealloc");
}

@end
