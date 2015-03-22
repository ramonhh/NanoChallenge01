//
//  CIRSound.m
//  NanoChallenge01
//
//  Created by Ramon Honorio on 3/22/15.
//  Copyright (c) 2015 CIR. All rights reserved.
//

#import "CIRSound.h"

@implementation CIRSound

- (void) play:(SoundManager *)m {
    [m playSound:self];
}

- (NSString *) description {
    return [NSString stringWithFormat:@"%@.mp3", self.name];
}

@end