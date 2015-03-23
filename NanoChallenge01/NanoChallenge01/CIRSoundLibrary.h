//
//  CIRSoundLibrary.h
//  NanoChallenge01
//
//  Created by Ramon Honorio on 3/22/15.
//  Copyright (c) 2015 CIR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CIRSound.h"

@interface CIRSoundLibrary : NSObject
{
    NSMutableArray *_library;
}

@property (nonatomic) NSArray *library;
@property (nonatomic) CIRSound *current;

- (void) addSound:(CIRSound *)s;
- (void) removeSound:(CIRSound *)s;
- (CIRSound *) randomSound;
- (void) loadAllSounds;

@end
