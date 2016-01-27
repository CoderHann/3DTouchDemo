//
//  BSDetailViewController.m
//  3DTouchDemo
//
//  Created by roki on 16/1/26.
//  Copyright © 2016年 roki. All rights reserved.
//

#import "BSDetailViewController.h"

@interface BSDetailViewController ()

@end

@implementation BSDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.navTitle;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(86, 100, 200, 150)];
    imageView.image = [UIImage imageNamed:@"imageone"];
    UILabel *githubName = [[UILabel alloc] init];
    githubName.text = @"ITBigSea";
    githubName.textColor = [UIColor blueColor];
    githubName.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    githubName.frame = CGRectMake(136, 270, 100, 30);
    githubName.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:imageView];
    [self.view addSubview:githubName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    //
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"删除" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        if ([self.delegate respondsToSelector:@selector(detailViewController:DidSelectedDeleteItem:)]) {
            [self.delegate detailViewController:self DidSelectedDeleteItem:self.navTitle];
        }
    }];
    //
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"返回" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        if ([self.delegate respondsToSelector:@selector(detailViewControllerDidSelectedBackItem:)]) {
            [self.delegate detailViewControllerDidSelectedBackItem:self];
        }
    }];
    
    NSArray *actions = @[action1,action2];
    
    return actions;
}
@end
