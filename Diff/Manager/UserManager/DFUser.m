//
//  QUUser.m
//  Questions
//
//  Created by fengj on 2019/3/14.
//  Copyright © 2019 JiangQian-Tec. All rights reserved.
//

#import "DFUser.h"

@implementation DFUser

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"userId" : @"id",};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSNumber *createTime = dic[@"createTime"];
    if (![createTime isKindOfClass:[NSNumber class]]) {
        _createTime = nil;
    } else {
        _createTime = [NSDate dateWithTimeIntervalSince1970:createTime.floatValue/1000.f];
    }
    return YES;
}

- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    if (!_createTime) {
        dic[@"createTime"] = @"";
    } else {
        dic[@"createTime"] = @(_createTime.timeIntervalSince1970);
    }
    return YES;
}

@end
