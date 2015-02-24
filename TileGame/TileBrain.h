//
//  TileBrain.h
//  TileGame
//
//  Created by Connor Kuehnle on 2/16/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TileBrain : NSObject

-(TileBrain *) initWithButtonArray: (NSArray *) inButtons andDifficultyValue: (int) inDifficulty;
-(void) setDifficulty: (int) inDifficulty;
-(UIButton *) swipeMade: (UISwipeGestureRecognizer *) direction;
-(void) resetBoard;
-(NSMutableArray *) shuffleBoard;
-(BOOL) playerHasWon;

typedef NS_ENUM(int, direction){
    left,
    right,
    up,
    down
};

typedef NS_ENUM(int, gameState){
    preGame,
    playing,
    won
};

@end
