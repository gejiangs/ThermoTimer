//
//  ByteUtil.h
//  Doss
//
//  Created by huang on 14/7/30.
//  Copyright (c) 2014年 dacheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ByteUtil : NSObject

//short转byte[] 小端 低位在前 高位在后
+ (Byte *)shortToByte:(int)a;

/**
 * byte数组转成int值 小端
 *
 * @param b
 * @return
 */
+ (int)lowByteArray2int:(Byte*)b Length:(int)length;
+ (NSData *)hexStringToData:(NSString *)hexStr ;

+ (long)byteArrayToLong:(Byte*) b;

+ (int)hexStringToint:(NSString *)hexStr;
+ (NSString *)hexStringTostring:(NSString *)hexStr;

+ (NSString *)ToHex:(int)tmpid;


+ (NSString *)stringToHexString:(NSString *)str;

//+ (NSString *)cookModelTohexStr:(NSString *)cookModel;
//
//+ (NSString *)cookModelHexStrToName:(NSString *)hexStr;

+ (NSString *)changeLanguage:(NSString*)chinese;

+ (NSString *)hexStringToTimeString:(NSString *)hexTimeStr;

+ (NSString *)stringFromHexString:(NSString *)hexString;

@end
