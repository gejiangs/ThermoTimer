//
//  ByteUtil.m
//  Doss
//
//  Created by huang on 14/7/30.
//  Copyright (c) 2014年 dacheng. All rights reserved.
//

#import "ByteUtil.h"

@implementation ByteUtil

//short转byte[] 小端 低位在前 高位在后
+ (Byte *)shortToByte:(int)a{
    Byte *byte = (Byte *)malloc(2);
    byte[0] = (Byte) a & 0xFF;
    byte[1] = (Byte) ((a >> 8) & 0xFF);
    return byte;
}

/**
 * byte数组转成int值 小端
 *
 * @param b
 * @return
 */
+ (int)lowByteArray2int:(Byte*)b Length:(int)length{
    Byte *a = (Byte*)malloc(4);
    /*
     * int i = a.length - 1, j = b.length - 1; for (; i >= 0; i--, j--) {//
     * 从b的尾部(即int值的低位)开始copy数据 if (j >= 0) a[i] = b[j]; else a[i] = 0;//
     * 如果b.length不足4,则将高位补0 }
     */
    int j = length - 1;
    for (int i = 0; i < 4; i++) {
        if (i <= j)
            a[i] = b[i];
        else {
            a[i] = 0;
        }
    }
    int v0 = (a[3] & 0xff) << 24;// &0xff将byte值无差异转成int,避免Java自动类型提升后,会保留高位的符号位
    int v1 = (a[2] & 0xff) << 16;
    int v2 = (a[1] & 0xff) << 8;
    int v3 = (a[0] & 0xff);
    return v0 + v1 + v2 + v3;
}

+ (long)byteArrayToLong:(Byte*) b {
    return (b[3] & 0xFF) | (b[2] & 0xFF) << 8 | (b[1] & 0xFF) << 16
    | (b[0] & 0xFF) << 24;
    
}

+ (int)hexStringToint:(NSString *)hexStr{
    
    unsigned int anInt;
    NSString * hexCharStr = [hexStr substringWithRange:NSMakeRange(0, hexStr.length)];
    NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
    [scanner scanHexInt:&anInt];
//    DLog(@"hex %@ to  int %d",hexStr,anInt);
    return anInt;
    
}

//十进制转十六进制
+ (NSString *)ToHex:(int)tmpid
{
    NSString *endtmp=@"";
    NSString *nLetterValue;
    NSString *nStrat;
    int ttmpig=tmpid%16;
    int tmp=tmpid/16;
    switch (ttmpig)
    {
        case 10:
            nLetterValue =@"A";break;
        case 11:
            nLetterValue =@"B";break;
        case 12:
            nLetterValue =@"C";break;
        case 13:
            nLetterValue =@"D";break;
        case 14:
            nLetterValue =@"E";break;
        case 15:
            nLetterValue =@"F";break;
        default:nLetterValue=[[NSString alloc]initWithFormat:@"%i",ttmpig];
            
    }
    switch (tmp)
    {
        case 10:
            nStrat =@"A";break;
        case 11:
            nStrat =@"B";break;
        case 12:
            nStrat =@"C";break;
        case 13:
            nStrat =@"D";break;
        case 14:
            nStrat =@"E";break;
        case 15:
            nStrat =@"F";break;
        default:nStrat=[[NSString alloc]initWithFormat:@"%i",tmp];
            
    }
    endtmp=[[NSString alloc]initWithFormat:@"%@%@",nStrat,nLetterValue];
//    DLog(@"int %d to hex %@",tmpid,[endtmp lowercaseString]);
    return [endtmp lowercaseString];
}

//+ (NSString *)stringToHexString:(NSString *)str{
//    NSMutableString *hexStr = [NSMutableString string];
//    for(int i = 0; i < str.length; i++){
//        
//        NSString *subStr = [str substringWithRange:NSMakeRange(i, 1)];
//        unichar ch = [subStr characterAtIndex:0];
////        DLog(@"substr %@ to int %d",subStr, (int)ch);
//        [hexStr appendString:[ByteUtil ToHex:(int)ch]];
//        
//    }
//    return hexStr;
//}

+ (NSData *)hexStringToData:(NSString *)hexStr {
    NSInteger length = hexStr.length / 2;
    Byte byte[length];
    
    
    for (int i = 0; i < hexStr.length; i+=2) {
        NSString * subStr = [hexStr substringWithRange:NSMakeRange(i, 2)];
        Byte b = [ByteUtil hexStringToint:subStr];
        byte[i/2] = b ;
    }
    NSData * data = [NSData dataWithBytes:byte length:length];
    return data;
        //
}

+ (NSString *)hexStringTostring:(NSString *)hexStr{
    NSMutableString *string = [NSMutableString string];
    
    for (int i = 0; i < hexStr.length; i+=2) {
        NSString * subStr = [hexStr substringWithRange:NSMakeRange(i, 2)];
        const char ch = [ByteUtil hexStringToint:subStr];
        
        if (ch == '\0') {
            continue;
        }
//    
    }
    return string;
}

+ (NSString *)stringFromHexString:(NSString *)hexString { //
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:NSASCIIStringEncoding];
    NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString; 
    
    
}

//普通字符串转换为十六进制的。

+ (NSString *)stringToHexString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr]; 
    } 
    return hexStr; 
}

//+ (NSString *)cookModelTohexStr:(NSString *)cookModel
//{
//    if ([cookModel isEqualToString:COOK_SOUP_CN]) {
//        return COOK_SOUP;
//    } else if ([cookModel isEqualToString:COOK_BARBECUE_CN]) {
//        return COOK_BARBECUE;
//    } else if ([cookModel isEqualToString:COOK_STIR_FRYING_CN]) {
//        return COOK_STIR_FRYING;
//    } else if ([cookModel isEqualToString:COOK_STEWING_CN]) {
//        return COOK_STEWING;
//    } else if ([cookModel isEqualToString:COOK_HOT_PUB_CN]) {
//        return COOK_HOT_PUB;
//    } else if ([cookModel isEqualToString:COOK_BOILING_WATER_CN]) {
//        return COOK_BOILING_WATER;
//    } else return nil;
//}
//
//+ (NSString *)cookModelHexStrToName:(NSString *)hexStr
//{
//    if ([hexStr isEqualToString:@"01"]) {
//        return COOK_SOUP_CN;
//    } else if ([hexStr isEqualToString:@"02"]) {
//        return COOK_STIR_FRYING_CN;
//    } else if ([hexStr isEqualToString:@"03"]) {
//        return COOK_BARBECUE_CN;
//    } else if ([hexStr isEqualToString:@"04"]) {
//        return COOK_BOILING_WATER_CN;
//    } else if ([hexStr isEqualToString:@"05"]) {
//        return COOK_HOT_PUB_CN;
//    } else if ([hexStr isEqualToString:@"06"]) {
//        return COOK_STEWING_CN;
//    } else if ([hexStr isEqualToString:@"07"]) {
//        return COOK_CUSTOM_CN;
//    } else return @"";
//}

//发送数据时,16进制数－>Byte数组->NSData,加上校验码部分
+(NSData *)hexToByteToNSData:(NSString *)str{
    int j=0;
    Byte bytes[[str length]/2];
    for(int i=0;i<[str length];i++)
    {
        int int_ch;  ///两位16进制数转化后的10进制数
        unichar hex_char1 = [str characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
        i++;
        unichar hex_char2 = [str characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char2 >= 'A' && hex_char2 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            int_ch2 = hex_char2-87; //// a 的Ascll - 97
        int_ch = int_ch1+int_ch2;
        bytes[j] = int_ch;  ///将转化后的数放入Byte数组里
        //        if (j==[str length]/2-2) {
        //            int k=2;
        //            int_ch=bytes[0]^bytes[1];
        //            while (k
        //                int_ch=int_ch^bytes[k];
        //                k++;
        //            }
        //            bytes[j] = int_ch;
        //        }
        j++;
    }
    NSData *newData = [[NSData alloc] initWithBytes:bytes length:[str length]/2 ];
    NSLog(@"%@",newData);
    return newData;
}

+(NSString*)changeLanguage:(NSString*)chinese{
    NSString *strResult;
    NSLog(@"chinese:%@",chinese);
    if (chinese.length%2==0) {
        //第二次转换
        NSData *newData = [ByteUtil hexToByteToNSData:chinese];
        unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingASCII);
        strResult = [[NSString alloc] initWithData:newData encoding:encode];
        NSLog(@"strResult:%@",strResult);
    }else{
        NSString *strResult = @"已假定是汉字的转换，所传字符串的长度必须是4的倍数!";
        NSLog(@"%@",strResult);
        return NULL;
    }
    return strResult;
}

+ (NSString *)hexStringToTimeString:(NSString *)hexTimeStr
{
    int time = [self hexStringToint:hexTimeStr];
    NSString * sTime = [NSString stringWithFormat:@"%02d:%02d",time/60,time%60];
    return sTime;
}


@end
