//
//  CIRSoundLibrary.m
//  NanoChallenge01
//
//  Created by Ramon Honorio on 3/22/15.
//  Copyright (c) 2015 CIR. All rights reserved.
//

#import "CIRSoundLibrary.h"
#import "CIRSound.h"

@implementation CIRSoundLibrary

- (NSArray *) library{
    return _library;
}

- (void) setLibrary:(NSArray *)library{
    [_library setArray:library];
}

- (void) addSound:(CIRSound *) s{
    [_library addObject:s];
}

- (void) removeSound:(CIRSound *)s{
    [_library removeObject:s];
}

- (CIRSound *) randomSound {
    NSUInteger random = arc4random() % [_library count];
    
    if (_library[random]!=self.current) {
        return [_library objectAtIndex:random];
    } else
        return self.randomSound;
}

- (void) loadAllSounds {
    CIRSound *s = [[CIRSound alloc] init];
    NSArray *options = [[NSArray alloc] init];
    
    [s setName:@"alarm"];
    options = @[@"Clock alarm",
                @"Stone crusher",
                @"Telephone ringing",
                @"Old car running"];
    
    [self addSound:s];
    
    
    
    
}

@end
