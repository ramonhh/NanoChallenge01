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
    NSUInteger randomIndex;
    UIImage *answerImage;
    Sound *answerSound;
}

@property (nonatomic) CIRSoundImage *files;

@end

@implementation CIRSoundTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.files = [[CIRSoundImage alloc] init];
    
    [[SoundManager sharedManager] prepareToPlay];
    
    [[SoundManager sharedManager] setMusicVolume:0.1];
    [[SoundManager sharedManager] setSoundVolume:1];
    
    _buttonArray = @[self.option1, self.option2, self.option3, self.option4];
    inGame = NO;
}

- (void) viewWillAppear:(BOOL)animated {
    [[SoundManager sharedManager] playMusic:@"backgroundMusic.mp3" looping:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playOnTouch:(UIButton *)sender{
    if(!inGame)
        [self newGame];
    else {
        [answerSound stop];
        [[SoundManager sharedManager] playSound:answerSound.name];
        
    }
}

- (void) newGame {
    // Gerando um index aleatorio em busca de uma nova resposta
    answerIndex = arc4random() % [self.files.sounds count];
    
    // Criando um novo som
    answerSound = [[Sound alloc] initWithContentsOfFile:self.files.sounds[answerIndex]];
    [[SoundManager sharedManager] playSound:answerSound.name];
    
    answerImage = [UIImage imageNamed:self.files.images[answerIndex]];
    
    randomIndex = arc4random() % (4);
    
    [_buttonArray[randomIndex] setImage:answerImage forState:UIControlStateNormal];
    
    long indexRestante;
    NSMutableArray *posicoes = [NSMutableArray array];
    [posicoes addObject:[NSNumber numberWithLong:answerIndex]];
    
    for (UIButton *b in _buttonArray) {
        if (![b isEqual:_buttonArray[randomIndex]]) {
            indexRestante = arc4random() % [self.files.sounds count];
            NSLog(@"indexRestante random: %ld", indexRestante);
            for (int i = 0; i < posicoes.count; i++) {
                if ([posicoes[i] longValue] == indexRestante) {
                    NSLog(@"--- %ld ja encontrado", indexRestante);
                    indexRestante = arc4random() % [self.files.sounds count];
                    NSLog(@"Novo valor: %ld", indexRestante);
                    i = 0;
                }
            }
            
            UIImage *img = [UIImage imageNamed:self.files.images[indexRestante]];
            [posicoes addObject:[NSNumber numberWithLong:indexRestante]];
            
            [b setImage:img forState:UIControlStateNormal];
        }
    }
    
    inGame = YES;
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
