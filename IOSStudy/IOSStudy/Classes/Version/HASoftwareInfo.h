//
//  HASoftwareInfo.h
//  IOSStudy
//
//  Created by haiwang on 14-9-18.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HASuperRespResult.h"

@interface HASoftwareInfo : HASuperRespResult

@property (nonatomic, copy) NSString *kind;

@property (nonatomic, copy) NSString *supportedDevices;

@property (nonatomic, copy) NSString *artistId;

@property (nonatomic, copy) NSString *artistName;

@property (nonatomic, copy) NSString *version;

@property (nonatomic, copy) NSString *bundleId;

@property (nonatomic, copy) NSString *trackId;

@property (nonatomic, copy) NSString *trackName;

@property (nonatomic, copy) NSString *fileSizeBytes;

@property (nonatomic, copy) NSString *trackViewUrl;

@property (nonatomic, copy) NSString *minimumOsVersion;

@end
