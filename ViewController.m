//
//  ViewController.m
//  zkH5Game
//
//  Created by 程强 on 2024/3/13.
//

#import "ViewController.h"
#import "CustomNSURLProtocol.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setProtocol];
    
    //WKWebview *wk = ········
}

- (void)setProtocol
{
    
    Class cls = NSClassFromString(@"WKBrowsingContextController");
    
    SEL sel = NSSelectorFromString(@"registerSchemeForCustomProtocol:");
    if ([(id)cls respondsToSelector:sel]) {
        
        [(id)cls performSelector:sel withObject:@"http"];
        
        [(id)cls performSelector:sel withObject:@"https"];
    }
    
    [NSURLProtocol registerClass:[CustomNSURLProtocol class]];
}


@end
