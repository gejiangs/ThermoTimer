//
//  NSData+Utils.m
//  ThermoTimer
//
//  Created by gejiangs on 2019/10/29.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "NSData+Utils.h"

@implementation NSData (Utils)

-(NSString *)hexToString
{
    Byte *bytes = (Byte *)[self bytes];
    NSString *hexStr=@"";
    for(int i=0;i<[self length];i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1){
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        }
        else{
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    }
    hexStr = [hexStr lowercaseString];
    return hexStr;
}

-(NSString *)hexToStringMAC
{
    NSString *value = [[self hexToString] uppercaseString];
    
    NSMutableString *macString = [[NSMutableString alloc] init];
    [macString appendString:[[value substringWithRange:NSMakeRange(14, 2)] uppercaseString]];
    [macString appendString:@":"];
    [macString appendString:[[value substringWithRange:NSMakeRange(12, 2)] uppercaseString]];
    [macString appendString:@":"];
    [macString appendString:[[value substringWithRange:NSMakeRange(10, 2)] uppercaseString]];
    [macString appendString:@":"];
    [macString appendString:[[value substringWithRange:NSMakeRange(4, 2)] uppercaseString]];
    [macString appendString:@":"];
    [macString appendString:[[value substringWithRange:NSMakeRange(2, 2)] uppercaseString]];
    [macString appendString:@":"];
    [macString appendString:[[value substringWithRange:NSMakeRange(0, 2)] uppercaseString]];
    
    return macString;
}
@end
