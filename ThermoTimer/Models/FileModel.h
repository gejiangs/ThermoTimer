//
//  FileModel.h
//  IDPhoto
//
//  Created by gejiangs on 15/6/11.
//  Copyright (c) 2015年 jiang. All rights reserved.
//

#import "BaseModel.h"

@interface FileModel : BaseModel

@property (nonatomic, strong)   NSData *fileData;
@property (nonatomic, copy)     NSString *name;
@property (nonatomic, copy)     NSString *fileName;
@property (nonatomic, copy)     NSString *mimeType;

@end
