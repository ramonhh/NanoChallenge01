//
//  CIRSound.h
//  NanoChallenge01
//
//  Created by Ramon Honorio on 3/22/15.
//  Copyright (c) 2015 CIR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoundManager.h"

@interface CIRSound : NSObject

@property (nonatomic, copy) NSString *name;     // Same name of the file
@property (nonatomic) NSArray *options;         // Index 0 is the answer

- (void) play: (SoundManager *) m;

@end
