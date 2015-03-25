//
//  CIRSoundTestViewController.m
//  NanoChallenge01
//
//  Created by Ramon Honorio on 3/22/15.
//  Copyright (c) 2015 CIR. All rights reserved.
//

#import "CIRSoundTestViewController.h"
#import "SoundManager.h"

@interface CIRSoundTestViewController ()

@property (nonatomic, copy) NSArray *images;
@property (nonatomic, copy) NSArray *sounds;
@property (nonatomic, copy) NSArray *randomImages;

- (IBAction)playSound:(__unused UIButton *)sender;

@end

@implementation CIRSoundTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[SoundManager sharedManager] prepareToPlay];
    [[SoundManager sharedManager] playMusic:@"Collage (Japanese instrumental music group) - Dohbutsu no Kohshin (Animal Parade).mp3" looping:YES];
    [[SoundManager sharedManager] setMusicVolume:0.1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playSound:(UIButton *)sender{
    [[SoundManager sharedManager] prepareToPlay];
    [[SoundManager sharedManager] playSound:@"alarm.mp3"];
    [[SoundManager sharedManager] setSoundVolume:0.5];
    
    //[self.option1 setTitle:@"Mudou!" forState: UIControlStateNormal];
    
    [self.option2 setImage:[UIImage imageNamed:@"cat.png"]
                  forState:UIControlStateNormal];
    [self.option2 setTitle:@"" forState: UIControlStateNormal];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
