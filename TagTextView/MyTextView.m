//
//  MyTextView.m
//  TagTextView
//
//  Created by shanpengtao on 15/11/2.
//  Copyright © 2015年 shanpengtao. All rights reserved.
//

#import "MyTextView.h"

@implementation MyTextView

- (BOOL)canBecameFirstResponder {
    return YES;
}

/* 选中文字后的菜单响应的选项 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(select:)) {
        [self.myDelegate textViewDidSelectedWithRange:self.selectedRange];
    }
    
//    if (action == @selector(copy:)) { // 菜单不能响应copy项
//        return NO;
//    }
//    else if (action == @selector(selectAll:)) { // 菜单不能响应select all项
//        return NO;
//    }
    

    return NO;
}

@end
