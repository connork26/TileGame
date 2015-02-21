//
//  TileBrain.m
//  TileGame
//
//  Created by Connor Kuehnle on 2/16/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import "TileBrain.h"

@interface TileBrain() {
    int difficulty;
    direction lastShuffle;
    gameState state;
}


@property (nonatomic) NSMutableArray * board;
@property (nonatomic) NSArray * buttons;

@end

@implementation TileBrain

-(TileBrain *)initWithButtonArray:(NSArray *)inButtons andDifficultyValue:(int)inDifficulty{
    self.buttons = inButtons;
    difficulty = inDifficulty;
    lastShuffle = left;
    state = preGame;
    
    
    return self;
}

-(void) setDifficulty:(int)inDifficulty{
    difficulty = inDifficulty;
}

//-(UIButton *) getButtonForShuffle {
//    int num = rand() % 4;
//    
//    if (num == 0 && [self validMove:left]) {
//        return [self moveFreeAndReturnSwappedObject:left];
//    } else if (num == 1 && [self validMove:right]){
//        return [self moveFreeAndReturnSwappedObject:right];
//    } else if (num == 2 && [self validMove:up]){
//        return [self moveFreeAndReturnSwappedObject:up];
//    } else if (num == 3 && [self validMove:down]){
//        return [self moveFreeAndReturnSwappedObject:down];
//    }
//    
//    return nil;
//}

-(NSArray *) shuffleBoard {
    [self resetBoard];
    state = playing;
    
    NSLog(@"Shuffling board\nShuffles: %i", difficulty);
    
    int shuffles = 0;
    
    while (shuffles < difficulty){
        switch (rand() % 4) {
            case 0:
                if ([self validMove:left] && (lastShuffle != left)){
                    [self moveFreeAndReturnSwappedObject:left];
                    shuffles++;
                    lastShuffle = left;
                }
                break;
            case 1:
                if ([self validMove:right] && (lastShuffle != right)){
                    [self moveFreeAndReturnSwappedObject:right];
                    shuffles++;
                    lastShuffle = right;
                }
                break;
            case 2:
                if([self validMove:up] && (lastShuffle != up)){
                    [self moveFreeAndReturnSwappedObject:up];
                    shuffles++;
                    lastShuffle = up;
                }
                break;
            case 3:
                if ([self validMove:down] && (lastShuffle != down)) {
                    [self moveFreeAndReturnSwappedObject:down];
                    shuffles++;
                    lastShuffle = down;
                }
                break;
        }
    }
    
    
    return [self arrayatiseBoard];
}

-(NSArray *) arrayatiseBoard{
    
    NSArray * ret = [[NSArray alloc] initWithObjects:
        self.board[0][0], self.board[0][1], self.board[0][2], self.board[0][3],
        self.board[1][0], self.board[1][1], self.board[1][2], self.board[1][3],
        self.board[2][0], self.board[2][1], self.board[2][2], self.board[2][3],
        self.board[3][0], self.board[3][1], self.board[3][2], self.board[3][3],
        nil];
    return ret;
    
}

-(UIButton *) swipeMade:(UISwipeGestureRecognizer *) recognizer{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight){
        if ([self validMove:left]){
            return [self moveFreeAndReturnSwappedObject:left];
        }
    } else if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft){
        if ([self validMove:right]){
            return [self moveFreeAndReturnSwappedObject:right];
        }
    } else if (recognizer.direction == UISwipeGestureRecognizerDirectionDown){
        if ([self validMove:down]){
            return [self moveFreeAndReturnSwappedObject:down];
        }
    } else if (recognizer.direction == UISwipeGestureRecognizerDirectionUp){
        if ([self validMove:up]){
            return [self moveFreeAndReturnSwappedObject:up];
        }
    }
    
    return nil;
}

-(BOOL) playerHasWon {
    
    for (int i = 0; i < 4; i++){
        if(self.board[0][i] != self.buttons[i]){
            return FALSE;
        }
    }
    for (int i = 0; i < 4; i++){
        if(self.board[1][i] != self.buttons[i+4]){
            return FALSE;
        }
    }
    for (int i = 0; i < 4; i++){
        if(self.board[2][i] != self.buttons[i+8]){
            return FALSE;
        }
    }
    for (int i = 0; i < 4; i++){
        if(self.board[3][i] != self.buttons[i+12]){
            return FALSE;
        }
    }
    
    return TRUE;
}
-(NSMutableArray *) board {
    if ( ! _board){
        _board = [[NSMutableArray alloc] initWithCapacity:4];
        [_board insertObject: [NSMutableArray arrayWithObjects: self.buttons[0], self.buttons[1], self.buttons[2], self.buttons[3], nil] atIndex:0];
        [_board insertObject: [NSMutableArray arrayWithObjects: self.buttons[4], self.buttons[5], self.buttons[6], self.buttons[7], nil] atIndex:1];
        [_board insertObject: [NSMutableArray arrayWithObjects: self.buttons[8], self.buttons[9], self.buttons[10], self.buttons[11], nil] atIndex:2];
        [_board insertObject: [NSMutableArray arrayWithObjects: self.buttons[12], self.buttons[13], self.buttons[14], self.buttons[15], nil] atIndex:3];
    }
    
    return _board;
}

-(void) resetBoard {
    self.board = [[NSMutableArray alloc] initWithCapacity:4];
    [self.board insertObject: [NSMutableArray arrayWithObjects: self.buttons[0], self.buttons[1], self.buttons[2], self.buttons[3], nil] atIndex:0];
    [self.board insertObject: [NSMutableArray arrayWithObjects: self.buttons[4], self.buttons[5], self.buttons[6], self.buttons[7], nil] atIndex:1];
    [self.board insertObject: [NSMutableArray arrayWithObjects: self.buttons[8], self.buttons[9], self.buttons[10], self.buttons[11], nil] atIndex:2];
    [self.board insertObject: [NSMutableArray arrayWithObjects: self.buttons[12], self.buttons[13], self.buttons[14], self.buttons[15], nil] atIndex:3];
}

-(UIButton *) swipeLeft {
    if ([self validMove:left]){
        return [self moveFreeAndReturnSwappedObject:left];
    }
    
    return nil;
}

-(UIButton *) swipeRight {
    if ([self validMove:left]){
        return [self moveFreeAndReturnSwappedObject:left];
    }
    
    return nil;
}

-(NSArray *) getFreePositionAsArray{
    
    for (NSInteger x = 0; x < 4; x++){
        for (NSInteger y = 0; y < 4; y++){
            if (self.board[x][y] == self.buttons[15]){
                return [NSArray arrayWithObjects: [NSNumber numberWithInt: x], [NSNumber numberWithInt: y], nil];
            }
        }
    }
    
    return nil;
}

-(UIButton *) getFreePositionAsObject{
    
    for (NSInteger x = 0; x < 4; x++){
        for (NSInteger y = 0; y < 4; y++){
            if (self.board[x][y] == self.buttons[15]){
                return self.board[x][y];
            }
        }
    }
    
    return nil;
}


-(UIButton *) moveFreeAndReturnSwappedObject: (direction) whichWay {
    NSArray * freePosition = [self getFreePositionAsArray];
    UIButton * freeObject = [self getFreePositionAsObject];
    
    int freeRow = [freePosition[0] intValue];
    int freeColumn = [freePosition[1] intValue];
    
    if (whichWay == left){
        UIButton * temp = self.board[freeRow][freeColumn - 1];
        
        self.board[freeRow][freeColumn] = temp;
        self.board[freeRow][freeColumn - 1] = freeObject;
        
        return temp;
    } else if (whichWay == right) {
        UIButton * temp = self.board[freeRow][freeColumn + 1];
        
        self.board[freeRow][freeColumn] = temp;
        self.board[freeRow][freeColumn + 1] = freeObject;
        return temp;
    } else if (whichWay == up){
        UIButton * temp = self.board[freeRow+1][freeColumn];
        
        self.board[freeRow][freeColumn] = temp;
        self.board[freeRow+1][freeColumn] = freeObject;
        return temp;
    } else if (whichWay == down){
        UIButton * temp = self.board[freeRow-1][freeColumn];
        
        self.board[freeRow][freeColumn] = temp;
        self.board[freeRow-1][freeColumn] = freeObject;
        return temp;
    }
    
    return nil;
}

-(BOOL) validMove: (direction) move{
    NSArray * freePosition = [self getFreePositionAsArray];
    int freeRow = [freePosition[0] intValue];
    int freeColumn = [freePosition[1] intValue];
    
    if (move == left){
        return (freeColumn != 0);
    } else if (move == right){
        return (freeColumn != 3);
    } else if (move == up){
        return (freeRow != 3);
    } else if (move == down){
        return (freeRow != 0);
    }
    
    return false;
}

@end
