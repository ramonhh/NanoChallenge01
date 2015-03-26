//
//  CIRSoundImage.m
//  NanoChallenge01
//
//  Created by Ramon Honorio on 3/24/15.
//  Copyright (c) 2015 CIR. All rights reserved.
//

#import "CIRSoundImage.h"

@implementation CIRSoundImage

- (void) loadImages{
    NSString *bundleRoot = [[NSBundle mainBundle] bundlePath];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSArray *dirContents = [fm contentsOfDirectoryAtPath:bundleRoot error:nil];
    NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self BEGINSWITH 'bt_'"];
    NSArray *onlyPNGs = [dirContents filteredArrayUsingPredicate:fltr];
    
    _images = onlyPNGs;
    //    NSLog(@"Imagens: %@", _images);
}

- (void) loadSounds {
    NSString *bundleRoot = [[NSBundle mainBundle] bundlePath];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSArray *dirContents = [fm contentsOfDirectoryAtPath:bundleRoot error:nil];
    NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self BEGINSWITH 'som_'"];
    NSArray *onlyMP3 = [dirContents filteredArrayUsingPredicate:fltr];
    
    _sounds = onlyMP3;
    //    NSLog(@"Sons: %@", _sounds);
}

- (id) init {
    if (self = [super init]) {
        [self loadImages];
        [self loadSounds];
    }
    return self;
}

@end
