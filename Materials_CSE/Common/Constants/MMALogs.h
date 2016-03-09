//
//  MMALogs.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/6.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define DLog(fmt, ...)                                                                             \
{                                                                                                  \
NSLog((@"%@:%d\n%s" fmt), [NSString stringWithUTF8String:__FILE__].lastPathComponent, __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__);              \
}
#define ELog(error)                                                                                \
{                                                                                                  \
if (error)                                                                                     \
DLog(@"\n%@\n%@", error.localizedDescription, error.userInfo);                                                  \
}
#else
#define DLog(...)
#define ELog(...)
#endif

#define ALog(fmt, ...)                                                                             \
{                                                                                                  \
NSLog((@"%s:%d %s" fmt), __FILE__, __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__);              \
}

@interface MMALogs : NSObject

@end
