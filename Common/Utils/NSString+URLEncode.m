//
//  NSString+URLEncode.m
//  TickTick
//
//  Created by 稻草人 on 15/12/24.
//  Copyright © 2015年 Appest. All rights reserved.
//

#import "NSString+URLEncode.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (URLEncode)

+ (NSString *) uniqueString {
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return uuidString;
}

- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)urlEncodedString {
    NSString *encodedString =
        [self
            stringByAddingPercentEncodingWithAllowedCharacters:
                [NSCharacterSet URLQueryAllowedCharacterSet]];
//                    characterSetWithCharactersInString:@"?!@#$^&%*+,:;='\"`<>()[]{}/\\| "]];
    if(!encodedString)
        encodedString = @"";
    return encodedString;
}

- (NSString *)urlDecodedString {
    NSString *decodedString = self.stringByRemovingPercentEncoding;
    // We need to replace "+" with " " because the CF method above doesn't do it
    return (!decodedString) ? @"" : [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}

@end
