//
//  UITableView+WBPinVerticalOffset.m
//  Example
//
//  Created by wenbo on 2021/1/25.
//

#import "UITableView+WBPinVerticalOffset.h"
#import <objc/runtime.h>

static const void *kPinVerticalOffsetKey = &kPinVerticalOffsetKey;

@implementation UITableView (WBPinVerticalOffset)

- (void)setWb_pinSectionHeaderVerticalOffset:(NSInteger)pinSectionHeaderVerticalOffset {
    objc_setAssociatedObject(self, kPinVerticalOffsetKey, @(pinSectionHeaderVerticalOffset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)wb_pinSectionHeaderVerticalOffset {
    return [objc_getAssociatedObject(self, kPinVerticalOffsetKey) integerValue];
}

- (BOOL)wb_isSetMainScrollViewContentInsetToZeroEnabled {
    //scrollView.contentInset.top不为0，且scrollView.contentInset.top不等于pinSectionHeaderVerticalOffset，即可认为列表正在刷新。所以这里必须要保证pinSectionHeaderVerticalOffset和MJRefresh的mj_insetT的值不相等。
    BOOL isRefreshing = self.contentInset.top != 0 && self.contentInset.top != self.wb_pinSectionHeaderVerticalOffset;
    return !isRefreshing;
}

- (void)wb_adjustMainScrollViewToTargetContentInsetIfNeeded:(UIEdgeInsets)insets delegate:(id)delegate {
    if (UIEdgeInsetsEqualToEdgeInsets(insets, self.contentInset) == NO) {
        self.delegate = nil;
        self.contentInset = insets;
        self.delegate = delegate;
    }
}

- (void)wb_handlePinVerticalOffset:(id)delegate {
    if (self.wb_pinSectionHeaderVerticalOffset != 0) {
        if (self.contentOffset.y >= self.wb_pinSectionHeaderVerticalOffset) {
            [self wb_adjustMainScrollViewToTargetContentInsetIfNeeded:UIEdgeInsetsMake(self.wb_pinSectionHeaderVerticalOffset, 0, 0, 0) delegate:delegate];
        } else {
            if ([self wb_isSetMainScrollViewContentInsetToZeroEnabled]) {
                [self wb_adjustMainScrollViewToTargetContentInsetIfNeeded:UIEdgeInsetsZero delegate:delegate];
            }
        }
    }
}

@end
