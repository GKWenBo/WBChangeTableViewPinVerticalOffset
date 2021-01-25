//
//  UITableView+WBPinVerticalOffset.h
//  Example
//
//  Created by wenbo on 2021/1/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (WBPinVerticalOffset)

/**
 顶部固定sectionHeader的垂直偏移量。数值越大越往下沉。
 */
@property (nonatomic, assign) NSInteger wb_pinSectionHeaderVerticalOffset;

- (void)wb_handlePinVerticalOffset:(id)delegate;

@end

NS_ASSUME_NONNULL_END
