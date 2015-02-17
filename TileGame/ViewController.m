//
//  ViewController.m
//  TileGame
//
//  Created by Connor Kuehnle on 2/16/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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
@property (weak, nonatomic) IBOutlet UISlider *shuffleSlider;

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
    
    [self.background addGestureRecognizer:leftRecognizer];
    [self.background addGestureRecognizer:rightRecognizer];
    [self.background addGestureRecognizer:upRecognizer];
    [self.background addGestureRecognizer:downRecognizer];
    
}

- (void) viewWasSwiped:(UISwipeGestureRecognizer *)recognizer {
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft){
        NSLog(@"left");
    } else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight){
        NSLog(@"right");
    } else if (recognizer.direction == UISwipeGestureRecognizerDirectionUp){
        NSLog(@"up");
    } else if (recognizer.direction == UISwipeGestureRecognizerDirectionDown){
        NSLog(@"down");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderChanged:(UISlider *)sender {
    return;
}


@end
