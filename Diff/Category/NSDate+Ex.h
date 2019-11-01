//
//  NSDate+Ex.h
//  Questions
//
//  Created by fengj on 2019/3/14.
//  Copyright © 2019 JiangQian-Tec. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Ex)
- (NSString *)replytime;
+ (NSString *)countDownTime:(NSInteger)restSecond;
@end

NS_ASSUME_NONNULL_END
