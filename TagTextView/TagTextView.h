//
//  TagTextView.h
//  bangjob
//
//  Created by shanpengtao on 15/9/17.
//  Copyright (c) 2015年 com.58. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextView.h"

typedef enum : NSUInteger {
    TEXTVIEWBEGINEDIT = 0,  // 开始输入
    TEXTVIEWCHANGEEDIT,     // 输入中
    TEXTVIEWENDEDIT,        // 结束输入
} TEXTVIEWEDITTYPE;

@interface TagTextView : UIView
{
    void (^textViewEditBlock)(TEXTVIEWEDITTYPE);
}

@property (nonatomic, strong) MyTextView *textView;

- (void)textViewEdit:(void(^)(TEXTVIEWEDITTYPE))aBlock;

@end
