//
//  LCObject.m
//  SettingChangeLanguage
//
//  Created by lu on 2020/6/4.
//  Copyright © 2020 sesame. All rights reserved.
//

#import "LCObject.h"

@implementation LCObject

- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }

- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }

- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }

- (NSString *)description {
//    NSDictionary *json = [self yy_modelToJSONObject];
//    NSLog(@"%@ = %@",NSStringFromClass([self class]), json);
    return [self yy_modelDescription];
}

//+ (NSDictionary *)modelContainerPropertyGenericClass{
//    return @{@"data" : [LCLatelyGameListModel class]};
//}

//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{@"lcdescription" : @"description"};
//}

@end
