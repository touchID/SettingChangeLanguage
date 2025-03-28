//
//  NSDate+LCAddition.m
//  JKFoundation
//
//  Created by admin on 2018/1/22.
//

#import "NSDate+LCAddition.h"

@implementation NSDate (LCAddition)

+ (void)lc_GeneratedBuildNumWithDelay:(NSInteger)delay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSDate *senddate = [NSDate date];
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyMMdd.HHmm"];
        NSString *date1 = [dateformatter stringFromDate:senddate];
        NSLog(@"生成build号: = %@", date1);
    });
}

@end
