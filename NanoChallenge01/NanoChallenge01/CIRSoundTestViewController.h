//
//  CIRSoundTestViewController.h
//  NanoChallenge01
//
//  Created by Ramon Honorio on 3/22/15.
//  Copyright (c) 2015 CIR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CIRSoundTestViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton *option1, *option2, *option3, *option4, *playButton;
@property (nonatomic, weak) IBOutlet UILabel *scoreLabel, *timeLapsedLabel;
@property (nonatomic, weak) IBOutlet UILabel *highScoreLabel;

@end
