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

@interface CIRSoundTestViewController ()
{
    NSArray *_buttonArray;
    BOOL inGame;
    
    // Propriedades auxiliares
    NSUInteger answerIndex;
    NSUInteger answerIndexOnArray;
    NSUInteger score;
    UIImage *answerImage, *imagemPadrao;
    Sound *answerSound;
}

@property (nonatomic) CIRSoundImage *files;

@end

@implementation CIRSoundTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    [self setLoseLabel:[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)]];
    [[self loseLabel] setCenter:self.view.center];
    
    CGRect frame = [[self loseLabel] frame];
    frame.origin.y = self.view.frame.size.height + frame.size.height;
    [[self loseLabel] setFrame:frame];
    
    [[self loseLabel] setText:@"ERROU!"];
    
    //[[self loseLabel] setFont:()]
    [self.view addSubview:[self loseLabel]];
    
    self.files = [[CIRSoundImage alloc] init];
    
    [[SoundManager sharedManager] prepareToPlay];
    
    [[SoundManager sharedManager] setMusicVolume:0.1];
    [[SoundManager sharedManager] setSoundVolume:1];
    
    _buttonArray = @[self.option1, self.option2, self.option3, self.option4];
    inGame = NO;
    
    score = 0;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %lu", score];
    imagemPadrao = [UIImage imageNamed:@"novacor.png"];
    
    NSLog(@"Sounds: %@ // %zd", self.files.sounds, [self.files.sounds count]);
    NSLog(@"Images: %@ // %zd", self.files.images, [self.files.images count]);
    
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
    if(!inGame)
        [self nextLevel];
    else {
        [[SoundManager sharedManager] playSound:answerSound.name];
    }
}

- (void) nextLevel {
    [[SoundManager sharedManager] stopAllSounds];
    // Gerando um index aleatorio em busca de uma nova resposta
    answerIndex = arc4random() % [self.files.sounds count];
    
    // Criando um novo som
    answerSound = [[Sound alloc] initWithContentsOfFile:self.files.sounds[answerIndex]];
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
    [self nextLevel];
}


- (IBAction) optionOnTouch:(UIButton*) sender{
    if ([sender isEqual:_buttonArray[answerIndexOnArray]]) {
        NSLog(@"Certa resposta!");
        
        score+=50;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %zd", score];
        [self.scoreLabel setNeedsDisplay];
        [self nextLevel];
        
    } else {
        NSLog(@"Errou!");
        
        [UIView animateWithDuration:1.0 animations:^{
            
            [[self loseLabel] setCenter:[self.view center]];
            
        }];
        
        [self performSelector:@selector(removeLoseLabelFromScreen) withObject:nil afterDelay:3.0];
        [self newGame];
    }
}

-(void)removeLoseLabelFromScreen {
    
    CGRect frame = [[self loseLabel] frame];
    frame.origin.y = self.view.frame.size.height + frame.size.height;
    [[self loseLabel] setFrame:frame];
    
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
