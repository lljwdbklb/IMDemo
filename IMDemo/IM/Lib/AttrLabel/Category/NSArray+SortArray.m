//
//  NSArray+SortArray.m
//  SendMessageMyDemo
//
//  Created by mmx on 14-7-23.
//  Copyright (c) 2014年 ztgame. All rights reserved.
//

#import "NSArray+SortArray.h"

@implementation NSArray (SortArray)
-(NSArray*)sortArray
{
    NSComparator cmptr = ^(id obj1, id obj2){
        
        NSString *st1=[[NSString stringWithFormat:@"%@",obj1] stringByReplacingOccurrencesOfString:@"[" withString:@""];
        st1=[st1 stringByReplacingOccurrencesOfString:@"]" withString:@""];
        
        NSString *st2=[[NSString stringWithFormat:@"%@",obj2] stringByReplacingOccurrencesOfString:@"[" withString:@""];
        st2=[st2 stringByReplacingOccurrencesOfString:@"]" withString:@""];
        
        if ([st1 integerValue] <[st2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([st1 integerValue] > [st2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    
//    //排序前
//    NSMutableString *outputBefore = [[NSMutableString alloc] init];
//    for(NSString *str in self){
//        [outputBefore appendFormat:@"%@",str];
//    }
//    NSLog(@"排序前:%@",outputBefore);
    
    //第一种排序
    NSArray *array = [self sortedArrayUsingComparator:cmptr];
    NSMutableArray *arraysss=[NSMutableArray array];
    for (int i=0;i<array.count; i++) {
        [arraysss addObject:array[array.count-1-i]];
    }
//    NSMutableString *outputAfter = [[NSMutableString alloc] init];
//    for(NSString *str in array){
//        [outputAfter appendFormat:@"%@",str];
//    }
//    NSLog(@"排序后:%@",outputAfter);
    return arraysss;
    
}

@end
