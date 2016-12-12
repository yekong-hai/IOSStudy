//
//  HASoftwareInfo.m
//  IOSStudy
//
//  Created by haiwang on 14-9-18.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HASoftwareInfo.h"

@implementation HASoftwareInfo

- (void)dealloc
{
    [_kind release];
    [_supportedDevices release];
    [_artistId release];
    [_artistName release];
    [_version release];
    [_bundleId release];
    [_trackId release];
    [_trackName release];
    [_fileSizeBytes release];
    [_trackViewUrl release];
    [_minimumOsVersion release];
    [super dealloc];
}

@end
