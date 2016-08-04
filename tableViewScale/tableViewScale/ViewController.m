//
//  ViewController.m
//  tableViewScale
//
//  Created by 卢大刚 on 16/8/3.
//  Copyright © 2016年 ldg. All rights reserved.
//

#define DGColors(r,g,b,a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0]
#define KheaderImageH 250

#import "ViewController.h"
#import "UIView+Size.h"
#import "UIImage+DGExtend.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,weak) UIImageView *imageView;

@end

@implementation ViewController

#pragma mark - 本文件访问的常量
static NSString * const tableViewCellReuseId = @"cell";

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];
    
    [self setupNavgation];
    [self setupTableView];
    [self setupHeaderView];
    
}

- (void)setupNavgation
{

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:nil action:nil];
}

- (void)setupNavTitleColorWithColor:(UIColor *)color
{
    UINavigationBar *navBar = self.navigationController.navigationBar;
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : color}];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : color} forState:UIControlStateNormal];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : color} forState:UIControlStateNormal];
}

- (void)setupTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableViewCellReuseId];
    self.tableView.contentInset = UIEdgeInsetsMake(KheaderImageH, 0, 0, 0);
}

- (void)setupHeaderView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"beautiful.jpg"]];
    imageView.width = self.tableView.width;
    imageView.height = KheaderImageH;
    imageView.y = -KheaderImageH;
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    self.imageView = imageView;
    [self.tableView addSubview:imageView];

}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellReuseId];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    return cell;
}


#pragma mark - scrollerView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;

    if (offset.y <= -KheaderImageH) {
        self.imageView.y = offset.y;
        self.imageView.height = -offset.y;
        
        // 让navgationBar的颜色变成透明
        self.title = nil;
        UINavigationBar *navBar = self.navigationController.navigationBar;
        UIImage *transparentImg = [UIImage imageWithColor:[UIColor colorWithWhite:0 alpha:0]];
        [navBar setBackgroundImage:transparentImg forBarMetrics:UIBarMetricsDefault];
        navBar.shadowImage = transparentImg;
        [self setupNavTitleColorWithColor:[UIColor greenColor]];
        
    } else {
        
        if (offset.y <= -64) { // 根据拉伸的距离显示导航栏
            CGFloat alapha = -64/ offset.y;
            UINavigationBar *navBar = self.navigationController.navigationBar;
            UIImage *transparentImg = [UIImage imageWithColor:[UIColor colorWithWhite:0 alpha:alapha]];
            [navBar setBackgroundImage:transparentImg forBarMetrics:UIBarMetricsDefault];
             navBar.shadowImage = nil;
        
            if (offset.y >= -150) { // 导航栏什么时候出来
                self.title = @"首页";
                [self setupNavTitleColorWithColor:[UIColor whiteColor]];
            }
        }
    }
}


@end
