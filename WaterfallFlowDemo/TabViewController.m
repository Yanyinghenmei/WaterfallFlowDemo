//
//  TabViewController.m
//  WaterfallFlowDemo
//
//  Created by Daniel on 16/3/10.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "TabViewController.h"
#import "CustomCell.h"

@interface TabViewController()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TabViewController {
    
    NSIndexPath *selectIndexPath;
    
    NSArray *imageArr;
    
    CGFloat lastHeight;
    CGFloat currentHeight;
    CGFloat nextHeight;
}

- (void)viewDidLoad {
    
    lastHeight = 100;
    currentHeight = 200;
    nextHeight = 100;
    
    imageArr = @[@"时尚资讯-1.jpg",@"时尚资讯-2.jpg",@"时尚资讯-3.jpg",
                 @"时尚资讯-4.jpg",@"时尚资讯-5.jpg",@"时尚资讯-6.jpg",
                 @"时尚资讯-11.jpg",@"时尚资讯-10.jpg",@"时尚资讯-7.jpg",
                 @"时尚资讯-12.jpg",@"时尚资讯-9.jpg",@"时尚资讯-8.jpg",];
    
    selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-200)];
    foot.backgroundColor = [UIColor cyanColor];
    tableView.tableFooterView = foot;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y<0||(int)scrollView.contentOffset.y/100 == imageArr.count-1) {
        return;
    }
    static CGFloat lastOffset = 0;
    
    
    if (scrollView.contentOffset.y<lastOffset) {
        // 向下滑动
        NSLog(@"下");
        lastHeight = 200-(scrollView.contentOffset.y-100*(int)(scrollView.contentOffset.y/100));
        nextHeight = 100;
        
        currentHeight = 100+(scrollView.contentOffset.y-100*(int)(scrollView.contentOffset.y/100));
        selectIndexPath = [NSIndexPath indexPathForItem:(int)(scrollView.contentOffset.y/100)+1 inSection:0];
    } else if (scrollView.contentOffset.y>lastOffset) {
        // 向上滑动
        NSLog(@"上");
        nextHeight = scrollView.contentOffset.y-100*(int)(scrollView.contentOffset.y/100)+100;
        lastHeight = 100;
        
        currentHeight = 200-(scrollView.contentOffset.y-100*(int)(scrollView.contentOffset.y/100));
        selectIndexPath = [NSIndexPath indexPathForItem:(int)(scrollView.contentOffset.y/100) inSection:0];
    }
    
    UITableView *tableView = (UITableView *)scrollView;
    
    NSArray *reloadArr;
    if (selectIndexPath.row==0) {
        reloadArr = @[selectIndexPath,
                      [NSIndexPath indexPathForItem:selectIndexPath.row+1 inSection:0]];
    } else if (selectIndexPath.row==imageArr.count-1) {
        reloadArr = @[selectIndexPath,
                      [NSIndexPath indexPathForItem:selectIndexPath.row-1 inSection:0]];
    } else {
        reloadArr = @[selectIndexPath,
                      [NSIndexPath indexPathForItem:selectIndexPath.row-1 inSection:0],
                      [NSIndexPath indexPathForItem:selectIndexPath.row+1 inSection:0]];
    }
    
    [tableView reloadRowsAtIndexPaths:reloadArr withRowAnimation:UITableViewRowAnimationNone];
    
    lastOffset = scrollView.contentOffset.y;
    
    NSLog(@"%lf, %ld", scrollView.contentOffset.y-100*(int)(scrollView.contentOffset.y/100), selectIndexPath.row);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return imageArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = [CustomCell cellWithTableView:tableView];
    
//    cell.imgView.image =[UIImage imageNamed:imageArr[indexPath.row]];
    NSArray *colors = @[[UIColor redColor],[UIColor blueColor],[UIColor yellowColor]];
    cell.backgroundColor = colors[indexPath.row%3];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (selectIndexPath == indexPath) {
//        
//    } else {
//        selectIndexPath = indexPath;
//        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == selectIndexPath.row) {
        return currentHeight;
    }
    
    if (indexPath.row == selectIndexPath.row -1) {
        return lastHeight;
    }
    
    if (indexPath.row == selectIndexPath.row +1) {
        return nextHeight;
    }
    
    return 100;
}

@end
