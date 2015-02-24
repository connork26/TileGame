//
//  ViewController.m
//  TileGame
//
//  Created by Connor Kuehnle on 2/16/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import "ViewController.h"
#import "TileBrain.h"

@interface ViewController (){
    BOOL animateInProgress;
    gameState state;
}

@property (weak, nonatomic) IBOutlet UILabel *background;

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button8;
@property (weak, nonatomic) IBOutlet UIButton *button9;
@property (weak, nonatomic) IBOutlet UIButton *button10;
@property (weak, nonatomic) IBOutlet UIButton *button11;
@property (weak, nonatomic) IBOutlet UIButton *button12;
@property (weak, nonatomic) IBOutlet UIButton *button13;
@property (weak, nonatomic) IBOutlet UIButton *button14;
@property (weak, nonatomic) IBOutlet UIButton *button15;
@property (weak, nonatomic) IBOutlet UIButton *buttonFree;

@property (weak, nonatomic) IBOutlet UISlider *difficultySlider;

@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *shuffleButton;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@property (strong, nonatomic) NSArray * buttons;
@property (strong, nonatomic) NSMutableArray * OGFramePostions;

@property (strong, nonatomic) TileBrain * brain;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISwipeGestureRecognizer * leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(viewWasSwiped:)];
    UISwipeGestureRecognizer * rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(viewWasSwiped:)];
    UISwipeGestureRecognizer * upRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(viewWasSwiped:)];
    UISwipeGestureRecognizer * downRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(viewWasSwiped:)];
    
    [leftRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [rightRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [upRecognizer setDirection:UISwipeGestureRecognizerDirectionUp];
    [downRecognizer setDirection:UISwipeGestureRecognizerDirectionDown];
    
    [self.view addGestureRecognizer:leftRecognizer];
    [self.view addGestureRecognizer:rightRecognizer];
    [self.view addGestureRecognizer:upRecognizer];
    [self.view addGestureRecognizer:downRecognizer];
    
    self.brain = [[TileBrain alloc] initWithButtonArray:self.buttons
                    andDifficultyValue: (([self.difficultySlider value] * 100) / 2)];
    
    animateInProgress = FALSE;
    
    self.OGFramePostions = [[NSMutableArray alloc] init];
    
    for (UIButton * button in self.buttons){
        [self.OGFramePostions addObject:[NSValue valueWithCGRect:button.frame]];
    }
    
    [self.buttonFree setAlpha:0.0];
    
    for (UIButton * button in self.buttons){
        button.layer.cornerRadius = 5;
    }
    
    self.resetButton.layer.cornerRadius = 5;
    self.shuffleButton.layer.cornerRadius = 5;
    
    state = preGame;
    
}

- (void) viewWasSwiped:(UISwipeGestureRecognizer *)recognizer {
    if (animateInProgress) {
        return;
    }
    
    UIButton * buttonToSwap = [self.brain swipeMade:recognizer];
    if (buttonToSwap){
        [self animateSwapWithButtonToSwap:buttonToSwap];
    }
    
    if (state == playing) {
        if ([self.brain playerHasWon]) {
            [self.infoLabel setText:@"You Won!!!"];
            state = won;
        }
    }
}

-(void) animateSwapWithButtonToSwap: (UIButton *) toSwap{
    animateInProgress = TRUE;
    CGRect oldFreeFrame = self.buttonFree.frame;
    CGRect oldSwapFrame = toSwap.frame;
    
    [UIView animateWithDuration:0.25 animations:^{
        toSwap.frame = oldFreeFrame;
    } completion:^(BOOL finished){
        self.buttonFree.frame = oldSwapFrame;
    }];
    
    animateInProgress = FALSE;
}

- (IBAction)resetButtonPressed:(UIButton *)sender {
    [self.infoLabel setText:@"Shuffle to Start Game!"];

    [self.brain resetBoard];
    [self resetBoard];
    
    state = preGame;
}

-(void) resetBoard {
    animateInProgress = TRUE;

    [UIView animateWithDuration:0.5 animations:^{
        int i = 0;
        for (UIButton * button in self.buttons){
            button.frame = [self.OGFramePostions[i++] CGRectValue];
        }
    }];
    
    animateInProgress = FALSE;
}

- (IBAction)shuffleButtonPressed:(UIButton *)sender {
    state = playing;
    [self.infoLabel setText:@""];
    [self resetBoard];
    
    NSMutableArray * tileSwaps = [self.brain shuffleBoard];
    
    [self animateSwaps:[tileSwaps objectEnumerator]];
    [self.infoLabel setText:@"Play!"];
}

-(void) animateSwaps: (NSEnumerator *) enumerator
{
    UIButton *buttonToAnimate = [enumerator nextObject];
    if( ! buttonToAnimate ) {
        animateInProgress = NO;
        return;
    }
    animateInProgress = YES;
    [UIView animateWithDuration:0.15 animations:^{
        CGRect temp = self.buttonFree.frame;
        self.buttonFree.frame = buttonToAnimate.frame;
        buttonToAnimate.frame = temp;
    } completion:^(BOOL finished) {
        [self animateSwaps:enumerator];
    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderChanged:(UISlider *)sender {
    [self.brain setDifficulty: (sender.value * 100) / 2];
    return;
}

-(NSArray *) buttons {
    if ( ! _buttons){
        _buttons = [[NSArray alloc] initWithObjects:
                    self.button1, self.button2, self.button3, self.button4,
                    self.button5, self.button6, self.button7, self.button8,
                    self.button9, self.button10, self.button11, self.button12,
                    self.button13, self.button14, self.button15, self.buttonFree,
                    nil];
    }
    
    return _buttons;
}

@end
