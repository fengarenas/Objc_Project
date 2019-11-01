//
//  NSDate+Ex.m
//  Questions
//
//  Created by fengj on 2019/3/14.
//  Copyright © 2019 JiangQian-Tec. All rights reserved.
//

#import "NSDate+Ex.h"

@implementation NSDate (Ex)

/*
 1分钟之内    刚刚
 1分钟到59分钟    1分钟前--59分钟前
 1个小时到24个小时    1小时1分钟前--23小时59分钟前
 超过一天的    2019年3月6日
 */
- (NSString *)replytime {
    long long interval = [self timeIntervalSinceNow];
    if (interval>0) {
        //date对象的时间大于当前时间
        return @"";
    } else {
        interval = llabs(interval);
    }
    if (interval < 60) {
        return @"刚刚";
    } else if (interval>=60 && interval<60*60) {
        return [NSString stringWithFormat:@"%@分钟前",@(interval/60)];
    } else if (interval>=60*60 && interval<60*60*24) {
        NSString *hour = [NSString stringWithFormat:@"%@小时",@(interval/(60*60))];
        NSString *min = [NSString stringWithFormat:@"%@分钟前",@((NSInteger)interval%(60*60)/60)];
        
        return [NSString stringWithFormat:@"%@%@",hour,min];
    } else if (interval >= 60*60*24) {
        //超过一天
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy年M月d日"];
        NSString *dateStr = [formatter stringFromDate:self];
        return dateStr;
    }
    return @"";
}


/*
 倒计时    1小时之内的    1分钟之后关闭--59分钟之后关闭
 24小时之内的    1小时1分钟后关闭--23小时59分钟后关闭
 超过一天的    1天1小时1分钟后关闭--***天23小时59分钟后关闭
 */
+ (NSString *)countDownTime:(NSInteger)restSecond {
    if (restSecond<0) {
        //date对象的时间大于当前时间
        return @"";
    } else {
        restSecond = llabs(restSecond);
    }
    if (restSecond < 60*60) {
        return [NSString stringWithFormat:@"%@分钟",@(restSecond/60)];
    } else if (restSecond>=60*60 && restSecond<60*60*24) {
        NSString *hour = [NSString stringWithFormat:@"%@小时",@(restSecond/(60*60))];
        NSString *min = [NSString stringWithFormat:@"%@分钟",@((NSInteger)restSecond%(60*60)/60)];
        
        return [NSString stringWithFormat:@"%@%@",hour,min];
    } else if (restSecond >= 60*60*24) {
        //超过一天
        NSString *day = [NSString stringWithFormat:@"%@天",@(restSecond/(60*60*24))];
        NSString *hour = [NSString stringWithFormat:@"%@小时",@((NSInteger)restSecond%(60*60*24) / (60*60))];
        NSString *min = [NSString stringWithFormat:@"%@分钟",@((NSInteger)restSecond%(60*60*24)%(60*60)/60)];
        
        return [NSString stringWithFormat:@"%@%@%@",day,hour,min];
    }
    return @"";
}

@end
