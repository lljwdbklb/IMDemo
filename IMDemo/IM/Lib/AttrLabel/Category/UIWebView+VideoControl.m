//
//  UIWebView+VideoControl.m
//  中国好舞蹈
//
//  Created by tanpengzhao on 14-4-16.
//
//

#import "UIWebView+VideoControl.h"

@implementation UIWebView (VideoControl)

- (BOOL)hasVideo
{
    __block BOOL hasVideoTag = NO;
    
    if (![[NSThread currentThread] isMainThread])
    {
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString * hasVideoTestString = @"document.documentElement.getElementsByTagName(\"video\").length";
            NSString * result = [self stringByEvaluatingJavaScriptFromString:hasVideoTestString];
            hasVideoTag = [result integerValue] >= 1? YES : NO;
            
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    else
    {
        NSString * hasVideoTestString = @"document.documentElement.getElementsByTagName(\"video\").length";
        NSString * result = [self stringByEvaluatingJavaScriptFromString:hasVideoTestString];
        hasVideoTag = [result integerValue] >= 1? YES : NO;
    }
    
    
    return hasVideoTag;
}
-(NSString *)getVideoTitle
{
    __block NSString * title = nil;
    
    if (![[NSThread currentThread] isMainThread])
    {
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *currentURL = [self stringByEvaluatingJavaScriptFromString:@"document.location.href"];
            title = [self stringByEvaluatingJavaScriptFromString:@"document.title"];
            NSLog(@"++++ URL:%@",currentURL);
            NSLog(@"++++ title:%@", title);
            
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    else
    {
        NSString *currentURL = [self stringByEvaluatingJavaScriptFromString:@"document.location.href"];
        title = [self stringByEvaluatingJavaScriptFromString:@"document.title"];
        NSLog(@"++++ URL:%@",currentURL);
        NSLog(@"++++ title:%@", title);
    }
    
    
    return title;
}
- (double)getVideoDuration
{
    __block double duration = 0;
    
    if ([self hasVideo])
    {
        if (![[NSThread currentThread] isMainThread])
        {
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString * requestDurationString = @"document.documentElement.getElementsByTagName(\"video\")[0].duration.toFixed(1)";
                NSString * result = [self stringByEvaluatingJavaScriptFromString:requestDurationString];
                NSLog(@"+++ Web Video Duration:%@",result);
                duration = [result doubleValue];
                
                dispatch_semaphore_signal(sema);
            });
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }
        else
        {
            NSString * requestDurationString = @"document.documentElement.getElementsByTagName(\"video\")[0].duration.toFixed(1)";
            NSString * result = [self stringByEvaluatingJavaScriptFromString:requestDurationString];
            NSLog(@"+++ Web Video Duration:%@",result);
            duration = [result doubleValue];
        }
    }
    
    return duration;
}
- (double)getVideoCurrentTime
{
    __block double currentTime = 0;
    
    if ([self hasVideo])
    {
        if (![[NSThread currentThread] isMainThread])
        {
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString * requestDurationString = @"document.documentElement.getElementsByTagName(\"video\")[0].currentTime.toFixed(1)";
                NSString * result = [self stringByEvaluatingJavaScriptFromString:requestDurationString];
                NSLog(@"+++ Web Video CurrentTime:%@",result);
                currentTime = [result doubleValue];
                
                dispatch_semaphore_signal(sema);
            });
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }
        else
        {
            NSString * requestDurationString = @"document.documentElement.getElementsByTagName(\"video\")[0].currentTime.toFixed(1)";
            NSString * result = [self stringByEvaluatingJavaScriptFromString:requestDurationString];
            NSLog(@"+++ Web Video CurrentTime:%@",result);
            currentTime = [result doubleValue];
        }
    }
    
    return currentTime;
}

- (int)play
{
    if ([self hasVideo])
    {
        if (![[NSThread currentThread] isMainThread])
        {
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString * requestDurationString = @"document.documentElement.getElementsByTagName(\"video\")[0].play()";
                [self stringByEvaluatingJavaScriptFromString:requestDurationString];
                
                dispatch_semaphore_signal(sema);
            });
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }
        else
        {
            NSString * requestDurationString = @"document.documentElement.getElementsByTagName(\"video\")[0].play()";
            [self stringByEvaluatingJavaScriptFromString:requestDurationString];
        }
    }
    return 0;
}
- (int)pause
{
    if ([self hasVideo])
    {
        if (![[NSThread currentThread] isMainThread])
        {
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString * requestDurationString = @"document.documentElement.getElementsByTagName(\"video\")[0].pause()";
                [self stringByEvaluatingJavaScriptFromString:requestDurationString];
                
                dispatch_semaphore_signal(sema);
            });
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }
        else
        {
            NSString * requestDurationString = @"document.documentElement.getElementsByTagName(\"video\")[0].pause()";
            [self stringByEvaluatingJavaScriptFromString:requestDurationString];
        }
    }
    return 0;
}
- (int)resume
{
    if ([self hasVideo])
    {
        if (![[NSThread currentThread] isMainThread])
        {
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString * requestDurationString = @"document.documentElement.getElementsByTagName(\"video\")[0].play()";
                [self stringByEvaluatingJavaScriptFromString:requestDurationString];
                
                dispatch_semaphore_signal(sema);
            });
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }
        else
        {
            NSString * requestDurationString = @"document.documentElement.getElementsByTagName(\"video\")[0].play()";
            [self stringByEvaluatingJavaScriptFromString:requestDurationString];
        }
    }
    return 0;
}
- (int)stop
{
    if ([self hasVideo])
    {
        if (![[NSThread currentThread] isMainThread])
        {
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString * requestDurationString = @"document.documentElement.getElementsByTagName(\"video\")[0].pause()";
                [self stringByEvaluatingJavaScriptFromString:requestDurationString];
                
                dispatch_semaphore_signal(sema);
            });
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }
        else
        {
            NSString * requestDurationString = @"document.documentElement.getElementsByTagName(\"video\")[0].pause()";
            [self stringByEvaluatingJavaScriptFromString:requestDurationString];
        }
    }
    
    return 0;
}
-(void)didAddSubview:(UIView *)subview{
    
}
-(void)willRemoveSubview:(UIView *)subvie
{
    
}
-(void)displayLayer:(CALayer *)layer
{
    
}

@end
