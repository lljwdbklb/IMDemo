//
//  UIWebView+VideoControl.h
//  中国好舞蹈
//
//  Created by tanpengzhao on 14-4-16.
//
//

#import <UIKit/UIKit.h>

@interface UIWebView (VideoControl)
-(BOOL)hasVideo;
-(NSString *)getVideoTitle;
-(double)getVideoDuration;
-(double)getVideoCurrentTime;

-(int)play;
-(int)pause;
-(int)resume;
-(int)stop;
@end
