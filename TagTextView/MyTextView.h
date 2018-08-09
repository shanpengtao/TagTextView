//
//  MyTextView.h
//  TagTextView
//
//  Created by shanpengtao on 15/11/2.
//  Copyright © 2015年 shanpengtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyTextViewDelegate <NSObject>

@optional

- (void)textViewDidSelectedWithRange:(NSRange)range;

@end

@interface MyTextView : UITextView

@property (nonatomic, assign) id <MyTextViewDelegate> myDelegate;

@end
