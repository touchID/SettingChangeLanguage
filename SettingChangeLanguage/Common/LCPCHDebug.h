//
//  LCPCHDebug.h
//  MedicalCompany
//
//  Created by admin on 2019/2/12.
//  Copyright © 2019年 ruanmeng. All rights reserved.
//

#ifndef LCPCHDebug_h
#define LCPCHDebug_h


///只有在 DEBUG 状态下才进行打印log 行号
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//#pragma clang diagnostic ignored "-Wno-ambiguous-macro"
#else
#define NSLog(...)
#endif

#import "LCThirdPartyLibraries.h"

#endif /* LCPCHDebug_h */
