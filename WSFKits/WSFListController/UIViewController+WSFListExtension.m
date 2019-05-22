//
//  UIViewController+WSFListExtension.m
//  BGFMDB
//
//  Created by wong on 2019/5/9.
//

#import "UIViewController+WSFListExtension.h"

@implementation UIViewController (WSFListExtension)

- (UITableView *)wsf_tableView {
    UITableView *table = objc_getAssociatedObject(self, _cmd);
    if (!table) {
        table = [self configTableView];
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        table.backgroundColor = self.view.backgroundColor;
        table.delegate = self;
        table.dataSource = self;
        table.showsVerticalScrollIndicator = NO;
        table.tableFooterView = [[UIView alloc] init];
        table.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestFirstPageData)];
        table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestNextPageData)];
        table.mj_footer.hidden = YES;
        ((MJRefreshStateHeader *)table.mj_header).lastUpdatedTimeLabel.hidden = YES;
        objc_setAssociatedObject(self, _cmd, table, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self.view addSubview:table];
    }
    return table;
}

- (UITableView *)configTableView {
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    return table;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)requestFirstPageData {

}

- (void)requestNextPageData {

}

@end
