//
//  UIViewController+WSFListExtension.h
//  BGFMDB
//
//  Created by wong on 2019/5/9.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (WSFListExtension) <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong, readonly) UITableView *wsf_tableView;

@end

NS_ASSUME_NONNULL_END
