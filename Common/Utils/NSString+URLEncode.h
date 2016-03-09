//
//  NSString+URLEncode.h
//  TickTick
//
//  Created by 稻草人 on 15/12/24.
//  Copyright © 2015年 Appest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncode)

+ (NSString *)uniqueString;

- (NSString *)md5;
- (NSString *)urlEncodedString;
- (NSString *)urlDecodedString;

@end
