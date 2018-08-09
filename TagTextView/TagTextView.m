//
//  TagTextView.m
//  bangjob
//
//  Created by shanpengtao on 15/9/17.
//  Copyright (c) 2015年 com.58. All rights reserved.
//

#import "TagTextView.h"

#define BLANK_HEIGHT 10

#define TEXT_HEIGHT 165

#define MAX_LENGTH 200

#define GRAY_COLOR [UIColor colorWithString:@"#a4a5a6" colorAlpha:1.0]

@interface TagTextView () <UITextViewDelegate, MyTextViewDelegate>
{
    UIView *_titleView;
    
    UILabel *_countLable;
    
    NSMutableArray *_rangeArray;
}
@end

@implementation TagTextView

#pragma mark  - loadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _rangeArray = [[NSMutableArray alloc] init];
        
        [self initMainView];
    }
    return self;
}

- (void)initMainView
{
    self.backgroundColor = [UIColor whiteColor];
    
    [self creatBlankView:CGRectMake(0, 0, SCREENWIDTH, BLANK_HEIGHT)];
    
    [self creatLineView:CGRectMake(0, BLANK_HEIGHT - 1, SCREENWIDTH, 1)];
    
    [self addSubview:[self textView]];
    
    [self creatTitleView:_textView];

    [self createCountLable:_textView];

    [self creatBlankView:CGRectMake(0, CGRectGetHeight(_textView.frame) + CGRectGetMinY(_textView.frame), SCREENWIDTH, BLANK_HEIGHT)];

    [self creatLineView:CGRectMake(0, CGRectGetHeight(_textView.frame) + CGRectGetMinY(_textView.frame), SCREENWIDTH, 1)];

//    [self creatLineView:CGRectMake(0, CGRectGetHeight(_textView.frame) + CGRectGetMinY(_textView.frame) + BLANK_HEIGHT - 1, SCREENWIDTH, 1)];
}

- (UIView *)textView
{
    if (!_textView) {
        _textView = [[MyTextView alloc] init];
        _textView.frame = CGRectMake(10, BLANK_HEIGHT, SCREENWIDTH - 20, TEXT_HEIGHT);
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.delegate = self;
        _textView.myDelegate = self;
        _textView.returnKeyType = UIReturnKeyDone;
        _textView.dataDetectorTypes = UIDataDetectorTypeCalendarEvent;
        _textView.selectable = YES;
    }
    return _textView;
}

- (void)creatBlankView:(CGRect)frame
{
    UIView *blankView = [[UIView alloc] initWithFrame:frame];
    blankView.backgroundColor = [UIColor colorWithString:@"#edeff1" colorAlpha:1.0];
    [self addSubview:blankView];
}

- (void)creatLineView:(CGRect)frame
{
    UIView *lineView=[[UIView alloc]initWithFrame:frame];
    lineView.layer.borderWidth = 0.5;
    lineView.layer.borderColor = [UIColor colorWithString:@"#e1e2e3" colorAlpha:1.0].CGColor;
    [self addSubview:lineView];
}

- (void)creatTitleView:(UIView *)view
{
    NSString *pladerStr = [NSString stringWithFormat:@"请输入内容...（输入#后面再跟几个字试试）"];
    
    CGSize size = [pladerStr tagSizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(CGRectGetWidth(view.frame) - 14, 60)];
    
    _titleView = [[UIView alloc] init];
    _titleView.frame = CGRectMake(7, 6, view.frame.size.width - 14 , size.height+2);
    _titleView.userInteractionEnabled = NO;
    [view addSubview:_titleView];

    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_titleView.frame), CGRectGetHeight(_titleView.frame))];
    titleLable.text = pladerStr;
    titleLable.font = [UIFont systemFontOfSize:13];
    titleLable.textColor = GRAY_COLOR;
    titleLable.numberOfLines = 0;
    [_titleView addSubview:titleLable];
}

- (void)createCountLable:(UIView *)view
{
    _countLable = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width-65, view.frame.size.height - 16 - 5, 50, 16)];
    _countLable.font = [UIFont systemFontOfSize:13];
    _countLable.textAlignment = NSTextAlignmentRight;
    _countLable.textColor = GRAY_COLOR;
    _countLable.text = @"200";
    [view addSubview:_countLable];
}


/**
 *  刷新右下角数字
 *
 *  @param count 已输入的数字
 */
- (void)refreshCountLable:(int)count
{
    if (count < MAX_LENGTH) {
        _countLable.text = [NSString stringWithFormat:@"%d", MAX_LENGTH - count];
        _countLable.textColor = [UIColor colorWithString:@"#e1e2e3" colorAlpha:1.0];
    }
    else {
        _countLable.text = @"0";
        _countLable.textColor = [UIColor colorWithString:@"#ff5845" colorAlpha:1.0];
    }
}

/**
 *  是否超出可输入的字数限制
 *
 */
- (BOOL)overInputLength:(NSString *)inputStr
{
    if (inputStr) {
        int length = (int)[inputStr length];
       
        if (length > MAX_LENGTH) {
            return YES;
        }
    }
    return NO;
}

#pragma mark  - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    // 输入或删除时的字符串位置及长度
    NSString *rangeStr = NSStringFromRange(range);
    NSString *location = [NSString stringWithFormat:@"%@", [[rangeStr componentsSeparatedByString:@","][0] componentsSeparatedByString:@"{"][1]];
    NSString *length = [NSString stringWithFormat:@"%@", [[rangeStr componentsSeparatedByString:@","][1] componentsSeparatedByString:@"}"][0]];

    /* 删除的逻辑处理 */
    int selectLocation = [location intValue];
    
    if ([text isEqualToString:@""] && [length intValue] != textView.attributedText.string.length) {
        for (NSString *rangeStr2 in _rangeArray) {
            
            NSString *location2 = [NSString stringWithFormat:@"%@", [[rangeStr2 componentsSeparatedByString:@","][0] componentsSeparatedByString:@"{"][1]];
            NSString *length2 = [NSString stringWithFormat:@"%@", [[rangeStr2 componentsSeparatedByString:@","][1] componentsSeparatedByString:@"}"][0]];
            
            if (([location2 intValue] + [length2 intValue] > [location intValue]) && [location2 intValue] <= [location intValue]) {
              
                range = NSRangeFromString(rangeStr2);
                selectLocation = [location2 intValue];
                break;
            }
        }
    }

    /* 超出字数限制时逻辑处理 */
    NSMutableString *textViewText = [[NSMutableString alloc] initWithString:textView.attributedText.string];

    [textViewText replaceCharactersInRange:range withString:text];

    if ([self overInputLength:textViewText])
    {
        [textViewText setString:[textViewText substringWithRange:NSMakeRange(0, range.location)]];
        NSString *str = textView.attributedText.string;
        NSString *backString = [str substringWithRange:NSMakeRange(range.location+range.length, [textView.attributedText.string length] - (range.location+range.length))];
        for(int i = 0; i < [text length]; i++) {
            
            [textViewText appendString:[text substringWithRange:NSMakeRange(i, 1)]];
            if ([self overInputLength:[NSString stringWithFormat:@"%@%@",textViewText,backString]]) {

                [self setAttributeText:[NSString stringWithFormat:@"%@%@",[textViewText substringWithRange:NSMakeRange(0, [textViewText length] - 1)], backString]];
                textViewText = nil;
                
                if (textView.attributedText.length == 0) {
                    _titleView.hidden = NO;
                } else {
                    _titleView.hidden = YES;
                }
                
                [self refreshCountLable:(int)textView.attributedText.length];
                
                return NO;
            }
        }
    }
    
    /* 判断输入的字是否是回车，即按下return */
    if ([text isEqualToString:@"\n"]) {
       
        [textView resignFirstResponder];
        return NO;
    }
    
    [self setAttributeText:textViewText];
    
    /* 光标位置 */
    if ([text isEqualToString:@""]) {
        textView.selectedRange = NSMakeRange(selectLocation, 0);
    }
    else {
        textView.selectedRange = NSMakeRange(selectLocation + 1, 0);
    }
    
    if (textView.attributedText.length == 0) {
        _titleView.hidden = NO;
    }
    else{
        _titleView.hidden = YES;
    }
    
    [self refreshCountLable:(int)textView.attributedText.length];
    
    return NO;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textViewEditBlock) {
        textViewEditBlock(TEXTVIEWBEGINEDIT);
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.attributedText.length == 0) {
        _titleView.hidden = NO;
    }
    else{
        _titleView.hidden = YES;
    }
    
    if (textViewEditBlock) {
        textViewEditBlock(TEXTVIEWCHANGEEDIT);
    }
    
    [self refreshCountLable:(int)textView.attributedText.length];
    
    NSMutableString *textViewText = [[NSMutableString alloc] initWithString:textView.attributedText.string];

    if (textViewText.length > 200)
    {
        [self setAttributeText:[NSString stringWithFormat:@"%@",[textViewText substringWithRange:NSMakeRange(0, 200)]]];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (!textView.attributedText.length) {
        _titleView.hidden = NO;
    }
    if (textViewEditBlock) {
        textViewEditBlock(TEXTVIEWENDEDIT);
    }
}

- (void)textViewEdit:(void(^)(TEXTVIEWEDITTYPE))aBlock
{
    if(aBlock){
        textViewEditBlock = [aBlock copy];
    }
}

- (void)setAttributeText:(NSString *)aText
{
    NSMutableArray *components = [NSMutableArray array];
    
    NSScanner *scanner = [NSScanner scannerWithString:aText];
    
    NSString *text = @"";
    
    while(![scanner isAtEnd]) {
        text = nil;
        [scanner scanUpToString:@" " intoString:&text];
        
        if (text && text.length > 0 && [text rangeOfString:@"#"].location != NSNotFound) {
            
            NSString *content = [text substringFromIndex:[text rangeOfString:@"#"].location];
            
            [components addObject:content];
        }
        
    }
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:aText];
    
    /* 全部字符串处理 */
    NSMutableDictionary *attributes1 = [[NSMutableDictionary alloc] init];
    [attributes1 setValue:[UIColor colorWithString:@"#1b1b1b" colorAlpha:1.0] forKey:NSForegroundColorAttributeName];
    [attributes1 setValue:[UIFont systemFontOfSize:13] forKey:NSFontAttributeName];
    [result addAttributes:attributes1 range:[aText rangeOfString:aText]];

    NSInteger index = 0;
    
    /* 每次变化都要重置标签range的数组 */
    [_rangeArray removeAllObjects];
    
    for (NSString *str in components) {
        
        if (index < aText.length) {
            NSRange range = [aText rangeOfString:str options:NSCaseInsensitiveSearch range:NSMakeRange(index, aText.length - index)];
            
            /* 保存特殊标签的range */
            [_rangeArray addObject:NSStringFromRange(range)];
            
            /* 标签字符串处理 */
            NSMutableDictionary *attributes2 = [[NSMutableDictionary alloc] init];
            [attributes2 setValue:[UIColor colorWithString:@"#43a8fd" colorAlpha:1.0] forKey:NSForegroundColorAttributeName];
            [attributes2 setValue:[UIFont systemFontOfSize:13] forKey:NSFontAttributeName];

            [result addAttributes:attributes2 range:range];
            
            index += range.length;
        }
    }
    
    _textView.attributedText = result;
}

#pragma mark - MyTextViewDelegate
- (void)textViewDidSelectedWithRange:(NSRange)range
{
    /* 用coreText和webView都可以很好处理富文本的操作包括文字链什么的
     * 但是UITextView在iOS7以前想做到有点难度
     * 如何才能监测到点击文本框里的文字呢
     * 这个问题我依然困惑
     * 希望高手能够解决
     */
    
    NSString *rangeStr = NSStringFromRange(range);
    NSString *location = [NSString stringWithFormat:@"%@", [[rangeStr componentsSeparatedByString:@","][0] componentsSeparatedByString:@"{"][1]];
    NSString *length = [NSString stringWithFormat:@"%@", [[rangeStr componentsSeparatedByString:@","][1] componentsSeparatedByString:@"}"][0]];

    if ([length intValue] != _textView.attributedText.string.length) {
        for (NSString *rangeStr2 in _rangeArray) {
            
            NSString *location2 = [NSString stringWithFormat:@"%@", [[rangeStr2 componentsSeparatedByString:@","][0] componentsSeparatedByString:@"{"][1]];
            NSString *length2 = [NSString stringWithFormat:@"%@", [[rangeStr2 componentsSeparatedByString:@","][1] componentsSeparatedByString:@"}"][0]];
            
            if (([location2 intValue] + [length2 intValue] > [location intValue]) && [location2 intValue] <= [location intValue]) {
                NSString *selectText = [_textView.attributedText.string substringWithRange:NSRangeFromString(rangeStr2)];
                NSLog(@"selectText:%@", selectText);
                
                break;
            }
        }
    }
}

@end
