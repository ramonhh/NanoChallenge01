//
//  CIRSoundTestViewController.m
//  NanoChallenge01
//
//  Created by Ramon Honorio on 3/22/15.
//  Copyright (c) 2015 CIR. All rights reserved.
//

#import "CIRSoundTestViewController.h"
#import "SoundManager.h"
#import "CIRSoundImage.h"
#import "AudioToolbox/AudioToolbox.h"

@interface CIRSoundTestViewController ()
{
    NSArray *_buttonArray;
    BOOL inGame;
    
    // Propriedades auxiliares
    NSUInteger answerIndex;
    NSUInteger answerIndexOnArray;
    NSUInteger score, highScore;
    UIImage *answerImage, *imagemPadrao;
    Sound *answerSound;
}

@property (nonatomic) CIRSoundImage *files;

@end

@implementation CIRSoundTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.files = [[CIRSoundImage alloc] init];
    
    [[SoundManager sharedManager] prepareToPlay];
    
    [[SoundManager sharedManager] setMusicVolume:0.1];
    [[SoundManager sharedManager] setSoundVolume:1];
    
    _buttonArray = @[self.option1, self.option2, self.option3, self.option4];
    inGame = NO;
    
    score = 0;
    self.scoreLabel.text = @"";
    imagemPadrao = [UIImage imageNamed:@"novacor.png"];
    
    // Snippet used to get your highscore from the prefs.
    highScore = [[[NSUserDefaults standardUserDefaults] objectForKey:@"HighScore"] integerValue];
    self.highScoreLabel.text = [NSString stringWithFormat:@"Highscore: %@", [NSNumber numberWithInteger:highScore]];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [[SoundManager sharedManager] playMusic:@"backgroundMusic.mp3" looping:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playOnTouch:(UIButton *)sender{
    [[SoundManager sharedManager] stopAllSounds];
    if(!inGame){
        [self nextLevel];
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %lu", score];
        [sender setTitle:@"     Play Sound     " forState:UIControlStateNormal];
    } else {
        [[SoundManager sharedManager] playSound:answerSound.name];
    }
}

- (void) nextLevel {
    [[SoundManager sharedManager] stopAllSounds];
    // Gerando um index aleatorio em busca de uma nova resposta
    answerIndex = arc4random() % [self.files.sounds count];
    
    // Criando um novo som
    answerSound = [[Sound alloc] initWithContentsOfFile:self.files.sounds[answerIndex]];
    if(inGame)
        [[SoundManager sharedManager] playSound:answerSound.name];
    
    // Gerando um numero aleatorio (0 ... 3)
    answerIndexOnArray = arc4random() % (4);
    NSUInteger answerOnArrayAux = answerIndexOnArray;
    
    
    NSMutableArray *imagesAlreadyOnView = [NSMutableArray array];
    [imagesAlreadyOnView addObject:@(answerIndex)];
    
    BOOL answerOnView = NO;
    for (UIButton *button in _buttonArray) {
        if (answerOnArrayAux>0 || answerOnView) {
            NSUInteger novoIndice = arc4random() % [self.files.images count];
            
            while ([imagesAlreadyOnView containsObject:@(novoIndice)]) {
                novoIndice = arc4random() % [self.files.images count];
            }
            [imagesAlreadyOnView addObject:@(novoIndice)];
            
            UIImage *img = [UIImage imageNamed:self.files.images[novoIndice]];
            [button setImage:img forState:UIControlStateNormal];
            answerOnArrayAux--;
        } else {
            answerImage = [UIImage imageNamed:self.files.images[answerIndex]];
            [button setImage:answerImage forState:UIControlStateNormal];
            answerOnView = YES;
        }
    }
    
    inGame = YES;
}


- (void) newGame {
    score = 0;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %lu", score];
    self.highScoreLabel.textColor = [UIColor whiteColor];
    [self nextLevel];
}


- (IBAction) optionOnTouch:(UIButton*) sender{
    if (inGame){
        if ([sender isEqual:_buttonArray[answerIndexOnArray]]) {
            NSLog(@"Certo!");
            
            [self changeScoreColor:[UIColor greenColor] :0.25];
            [self performSelector:@selector(greenToWhite) withObject:nil afterDelay:0.5];
            
            score+=50;
            self.scoreLabel.text = [NSString stringWithFormat:@"Score: %zd", score];
            [self.scoreLabel setNeedsDisplay];
            [self nextLevel];
            
            if(score > highScore){
                self.highScoreLabel.text = [NSString stringWithFormat:@"Highscore: %@", [NSNumber numberWithInteger:score]];
                self.highScoreLabel.textColor = [UIColor greenColor];
            }
            
        } else {
            NSLog(@"Errado!");
            
            [self changeScoreColor:[UIColor redColor] :0.25];
            [self performSelector:@selector(redToWhite) withObject:nil afterDelay:1];
            
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            inGame = NO;
            
            if (score > highScore){
                highScore = score;
                [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:highScore] forKey:@"HighScore"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                self.highScoreLabel.text = [NSString stringWithFormat:@"Highscore: %@", [NSNumber numberWithInteger:highScore]];
            }
            
            [self newGame];
        }
    }
}

- (void) greenToWhite {
    [UIView transitionWithView:self.view duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self.scoreLabel setTextColor:[UIColor whiteColor]];
        [self.scoreLabel setShadowColor:[UIColor blackColor]];
    } completion:nil];
}

- (void) redToWhite {
    [UIView transitionWithView:self.view duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self.scoreLabel setTextColor:[UIColor whiteColor]];
        [self.scoreLabel setShadowColor:[UIColor blackColor]];
    } completion:nil];
}

- (void) changeScoreColor :(UIColor *) textColor :(float) segundos {
    [UIView transitionWithView:self.view duration:segundos options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self.scoreLabel setTextColor:textColor];
        [self.scoreLabel setShadowColor:[UIColor blackColor]];
    } completion:nil];
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
