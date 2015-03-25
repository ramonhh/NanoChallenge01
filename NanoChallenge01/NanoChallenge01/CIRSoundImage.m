//
//  CIRSoundImage.m
//  NanoChallenge01
//
//  Created by Ramon Honorio on 3/24/15.
//  Copyright (c) 2015 CIR. All rights reserved.
//

#import "CIRSoundImage.h"

@implementation CIRSoundImage

- (NSString *) soundName {
    return [NSString stringWithFormat:@"%@.mp3", _soundName];
}

- (NSString *) imageName {
    return [NSString stringWithFormat:@"%@.png", _imageName];
}

@end
