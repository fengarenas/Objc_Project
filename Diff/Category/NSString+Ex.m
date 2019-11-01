//
//  NSString+Ex.m
//  Questions
//
//  Created by fengj on 2019/5/5.
//  Copyright © 2019 JiangQian-Tec. All rights reserved.
//

#import "NSString+Ex.h"

@implementation NSString (Ex)

+ (NSString *)stringFloat:(double)value {
    
    if (value-(int)value==0) {
        return [NSString stringWithFormat:@"%d",(int)value];
    } else {
        return [NSString stringWithFormat:@"%.1f",value];
    }
}
@end
