//
//  ViewController.m
//  TagTextView
//
//  Created by shanpengtao on 15/11/2.
//  Copyright © 2015年 shanpengtao. All rights reserved.
//

#import "ViewController.h"
#import "TagTextView.h"

@interface ViewController ()

@property (nonatomic, strong) TagTextView *tagView;
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"微博的连体字怎么做的呢";

    [self initNavigationRightTextButton:@"随便点一下" action:@selector(test) target:self];

    _tagView = [[TagTextView alloc] initWithFrame:CGRectMake(0, NAVBAR_DEFAULT_HEIGHT, SCREENWIDTH, 200)];
    [self.view addSubview:_tagView];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, NAVBAR_DEFAULT_HEIGHT + 200 + 10, SCREENWIDTH, SCREENHEIGHT - (NAVBAR_DEFAULT_HEIGHT + 200 + 10))];
    _webView.scrollView.bounces = NO;
    [self.view addSubview:_webView];
}

- (void)initNavigationRightTextButton:(NSString *)btnText action:(SEL)action target:(id)target
{
    NSDictionary  *attributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:16], NSForegroundColorAttributeName : [UIColor colorWithString:@"#ff7700" colorAlpha:1] } ;
    NSDictionary  *disableAttributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:16], NSForegroundColorAttributeName : [ UIColor  lightGrayColor] } ;
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc]initWithTitle:btnText
                                                                 style:UIBarButtonItemStylePlain
                                                                target:target
                                                                action:action];
    [rightBtn setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [rightBtn setTitleTextAttributes:disableAttributes forState:UIControlStateDisabled];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)test
{
    if (_tagView.textView.attributedText.string.length == 0) {
        return;
    }
 
     [self.view endEditing:YES];
    
    [_webView loadHTMLString:[Utility formatWithName:@"标题" value:_tagView.textView.attributedText.string] baseURL:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
