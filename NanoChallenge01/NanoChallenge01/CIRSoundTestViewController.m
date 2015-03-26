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
    
//    // Setando a imagem em uma posicao randomica (0 ... 3)
//    answerImage = [UIImage imageNamed:self.files.images[answerIndex]];
//    [_buttonArray[answerIndexOnArray] setImage:answerImage forState:UIControlStateNormal];
    
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
    
    
//    long indexRestante;
//    NSMutableArray *posicoes = [NSMutableArray array];
//    [posicoes addObject:[NSNumber numberWithLong:answerIndex]];
//    
//    for (UIButton *b in _buttonArray) {
//        if (![b isEqual:_buttonArray[answerIndexOnArray]]) {
//            indexRestante = arc4random() % [self.files.sounds count];
//            NSLog(@"indexRestante random: %ld", indexRestante);
//            for (int i = 0; i < posicoes.count; i++) {
//                if ([posicoes[i] longValue] == indexRestante) {
//                    NSLog(@"--- %ld ja encontrado", indexRestante);
//                    indexRestante = arc4random() % [self.files.sounds count];
//                    NSLog(@"Novo valor: %ld", indexRestante);
//                    i = 0;
//                }
//            }
//            
//            UIImage *img = [UIImage imageNamed:self.files.images[indexRestante]];
//            [posicoes addObject:[NSNumber numberWithLong:indexRestante]];
//            
//            [b setImage:img forState:UIControlStateNormal];
//        }
//    }
    
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
        [self newGame];
    }
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
