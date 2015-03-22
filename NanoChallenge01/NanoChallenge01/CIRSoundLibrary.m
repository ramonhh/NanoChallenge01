//
//  CIRSoundLibrary.m
//  NanoChallenge01
//
//  Created by Ramon Honorio on 3/22/15.
//  Copyright (c) 2015 CIR. All rights reserved.
//

#import "CIRSoundLibrary.h"

@implementation CIRSoundLibrary

- (NSArray *) library{
    return _library;
}

- (void) setLibrary:(NSArray *)library{
    [_library setArray:library];
}

- (void) addSound:(Sound *) s{
    [_library addObject:s];
}

- (void) removeSound:(Sound *)s{
    [_library removeObject:s];
}

@end
