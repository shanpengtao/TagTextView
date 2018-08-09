//
//  Utility.h
//  Demo
//
//  Created by shanpengtao on 15/10/29.
//  Copyright © 2015年 shanpengtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

+ (NSString *)formatWithName:(NSString *)name value:(NSString *)value;

@end


#pragma mark - UIColor Category
@interface UIColor (privateColor)

+ (UIColor *)colorWithString:(NSString *)colorValue colorAlpha:(float)alpha;

@end

#pragma mark - NSString Category
@interface NSString (systemVersion7)

- (CGSize)tagSizeWithFont:(UIFont *)font;

- (CGSize)tagSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

- (CGSize)tagSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)tagSizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end