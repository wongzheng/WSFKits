//
//  UILabel+WSFExtension.h
//  Pods
//
//  Created by wong on 2019/12/26.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (WSFExtension)

/**
  修改label内容距 `top` `left` `bottom` `right` 边距
 */
@property (nonatomic, assign) UIEdgeInsets yf_contentInsets;

- (void)setFont:(UIFont *)font textColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
