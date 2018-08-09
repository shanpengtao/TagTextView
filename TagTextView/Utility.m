//
//  Utility.m
//  Demo
//
//  Created by shanpengtao on 15/10/29.
//  Copyright © 2015年 shanpengtao. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (NSString *)formatWithName:(NSString *)name value:(NSString *)value
{
    NSString *html =
    @"<HTML>"
    "<HEAD>"
    "<script>"
    "function copyText() { document.getElementById('field2').value=document.getElementById('field1').value; }"
    "</script>"
    "</HEAD>"
    "<BODY>"
    "<H1 align='center'>%@</H1>"
//    "<H2>test一下</H2>"
//    "<P style='text-align:center'>%@</P>"
    "<div style='text-align:center;'>"
    "<input type='text' id='field1' style='text-align:center;display:inline-block;' value='%@'><br>"
    "<input type='text' id='field2' style='text-align:center;display:inline-block;'><br><br>"
    //    "<button onclick='copyText()'>复制</button>"
    "<input type='submit' name='submit' value='复制' style='width:200px;height:50px;display:inline-block;' onclick='copyText()'>"
    "</div>"
    "</BODY>"
    "</HTML>";
    NSString *content = [NSString stringWithFormat:html, name ,value];
    return content;
}

@end


@implementation UIColor (privateColor)

+ (UIColor *)colorWithString:(NSString *)colorValue colorAlpha:(float)alpha{
    
    UIColor *color = [UIColor clearColor];
    
    if ([[colorValue substringToIndex:1] isEqualToString:@"#"]) {
        
        if ([colorValue length]==7) {
            NSRange range = NSMakeRange(1,2);
            NSString *strRed = [colorValue substringWithRange:range];
            
            range.location = 3;
            NSString *strGreen = [colorValue substringWithRange:range];
            
            range.location = 5;
            NSString *strBlue = [colorValue substringWithRange:range];
            
            
            float r = [self getIntegerFromString:strRed];
            float g = [self getIntegerFromString:strGreen];
            float b = [self getIntegerFromString:strBlue];
            
            color = [UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:alpha];
        }
    }
    return color;
}

//十进制转十六进制
+ (int) getIntegerFromString:(NSString *)str
{
    int nValue = 0;
    for (int i = 0; i < [str length]; i++)
    {
        int nLetterValue = 0;
        
        if ([str characterAtIndex:i] >='0' && [str characterAtIndex:i] <='9') {
            nLetterValue += ([str characterAtIndex:i] - '0');
        }
        else{
            switch ([str characterAtIndex:i])
            {
                case 'a':case 'A':
                    nLetterValue = 10;break;
                case 'b':case 'B':
                    nLetterValue = 11;break;
                case 'c': case 'C':
                    nLetterValue = 12;break;
                case 'd':case 'D':
                    nLetterValue = 13;break;
                case 'e': case 'E':
                    nLetterValue = 14;break;
                case 'f': case 'F':
                    nLetterValue = 15;break;
                default:nLetterValue = '0';
            }
        }
        
        nValue = nValue * 16 + nLetterValue; //16进制
    }
    return nValue;
}

@end


@implementation NSString (systemVersion7)

- (CGSize)tagSizeWithFont:(UIFont *)font
{
    CGSize textSize = [self sizeWithAttributes:@{ NSFontAttributeName : font }];
    
    return textSize;
}

- (CGSize)tagSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGSize textSize = [self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName : font } context:nil].size;


    return textSize;
}

- (CGSize)tagSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = lineBreakMode;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize textSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;

    return textSize;
}

- (CGSize)tagSizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    return [self tagSizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:lineBreakMode];
}


@end



