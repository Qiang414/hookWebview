//
//  CustomNSURLProtocol.m
//  zkH5Game
//
//  Created by 程强 on 2024/3/13.
//

#import "CustomNSURLProtocol.h"
#import <CoreFoundation/CoreFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface CustomNSURLProtocol()<NSURLSessionDelegate>

@end

@implementation CustomNSURLProtocol


+ (BOOL)canInitWithRequest:(NSURLRequest *)request{
    
    NSString *abstring = request.URL.absoluteString;
    //自定义一个拦截标记
    if ([abstring containsString:@"tag=1"]) {
        return YES;
    }
    
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
    return request;
}

- (void)startLoading{
    
    NSString *urlPathString = super.request.URL.absoluteString;
    
    if ([urlPathString containsString:@"tag=1"]) {
        
        urlPathString = [urlPathString stringByReplacingOccurrencesOfString:@"tag=1" withString:@"tag=2"];
    }
    
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlPathString]];
    
    NSMutableDictionary *header = [NSMutableDictionary dictionary];
    
    header[@"Content-Length"] = [NSString stringWithFormat:@"%ld",imageData.length];
    
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:self.request.URL statusCode:200 HTTPVersion:@"1.1" headerFields:header];
    
    //回调
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
    [self.client URLProtocol:self didLoadData:imageData];
    [self.client URLProtocolDidFinishLoading:self];

}

- (void)stopLoading{
    NSLog(@"stop");
}

@end
