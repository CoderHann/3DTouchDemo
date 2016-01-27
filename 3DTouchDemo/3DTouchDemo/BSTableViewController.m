//
//  BSTableViewController.m
//  3DTouchDemo
//
//  Created by roki on 16/1/26.
//  Copyright © 2016年 roki. All rights reserved.
//

#import "BSTableViewController.h"
#import "BSDetailViewController.h"


@interface BSTableViewController ()<UIViewControllerPreviewingDelegate,BSDetailViewControllerDelegate>

@property (nonatomic,strong)NSMutableArray *items;
@property (nonatomic,weak)UITableViewCell *selectedCell;

@end

@implementation BSTableViewController

- (NSMutableArray *)items {
    if (!_items) {
        _items = [[NSMutableArray alloc] initWithObjects:@"one",@"two",@"three",@"four",@"five",@"six",@"seven",@"eight", nil];
    }
    return _items;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableView.backgroundColor = [UIColor greenColor];
    self.title = @"3DTouchDemo";
    self.tableView.rowHeight = 100;
    // 重要
    [self registerForPreviewingWithDelegate:self sourceView:self.view];

}

#pragma mark - UIViewControllerPreviewingDelegate

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    self.selectedCell = [self searchCellWithPoint:location];
    previewingContext.sourceRect = self.selectedCell.frame;
    
    BSDetailViewController *detailVC = [[BSDetailViewController alloc] init];
    detailVC.delegate = self;
    detailVC.navTitle = self.selectedCell.textLabel.text;
    return detailVC;
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self tableView:self.tableView didSelectRowAtIndexPath:[self.tableView indexPathForCell:self.selectedCell]];
}

// 根据一个点寻找对应cell并返回cell的frame
- (UITableViewCell *)searchCellWithPoint:(CGPoint)point {
    UITableViewCell *cell = nil;
    for (UIView *view in self.tableView.subviews) {
        NSString *class = [NSString stringWithFormat:@"%@",view.class];
        if (![class isEqualToString:@"UITableViewWrapperView"]) continue;
        for (UIView *tempView in view.subviews) {
            if ([tempView isKindOfClass:[UITableViewCell class]] && CGRectContainsPoint(tempView.frame, point)) {
                cell = (UITableViewCell *)tempView;
                break;
            }
        }
        break;
    }
    return cell;
}

#pragma mark - BSDetailViewControllerDelegate
- (void)detailViewControllerDidSelectedBackItem:(BSDetailViewController *)detailVC {
    NSLog(@"back");
}

- (void)detailViewController:(BSDetailViewController *)detailVC DidSelectedDeleteItem:(NSString *)navTitle {
    [self.items removeObject:navTitle];
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = self.items[indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row + 1];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    BSDetailViewController *detailVC = [[BSDetailViewController alloc] init];
    detailVC.navTitle = self.items[indexPath.row];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end

