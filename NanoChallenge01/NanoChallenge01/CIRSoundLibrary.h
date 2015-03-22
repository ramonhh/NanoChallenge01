//
//  CIRSoundLibrary.h
//  NanoChallenge01
//
//  Created by Ramon Honorio on 3/22/15.
//  Copyright (c) 2015 CIR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoundManager.h"

@interface CIRSoundLibrary : NSObject
{
    NSMutableArray *_library;
}

@property (nonatomic) NSArray *library;

- (void) addSound:(Sound *)s;
- (void) removeSound:(Sound *)s;
- (void) loadSounds;

@end
