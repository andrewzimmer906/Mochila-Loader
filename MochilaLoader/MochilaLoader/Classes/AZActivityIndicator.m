//
//  AZActivityIndicator.m
//  Mochilla
//
//  Created by Andrew Zimmer on 9/27/12.
//  Copyright (c) 2012 Mochila. All rights reserved.
//

#import "AZActivityIndicator.h"

#define CYCLE_LENGTH 1.0 // in seconds
#define CYCLE_FRAME 0.017 // in seconds
#define NOT_RUNNING_BAR_HEIGHT 2 // in points

/* This enum allows us to gracefully start and end animation, instead of doing it abruptly. */
typedef enum {
    NOT_RUNNING,
    STARTING,
    RUNNING,
    SHOULD_END,
    ENDING,
} AnimationStates;

@interface AZActivityIndicator()
-(void)setupIndicator;
-(void)update;
-(void)trueStopAnimating;
-(float)interpolate:(float)start end:(float)end perc:(float)perc;

@property(nonatomic, strong) NSArray *bars;
@property(nonatomic) NSInteger count;

@property(nonatomic) AnimationStates animationState;

@end

@implementation AZActivityIndicator

-(id)init {
    self = [self initWithFrame:CGRectMake(0, 0, 20, 16)];
    if(self) {
        [self setupIndicator];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupIndicator];
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self setupIndicator];
}

-(void)dealloc {
    [self stopAnimating];
}

#pragma mark - Events
-(void)startAnimating{
    if(self.isAnimating) return;
    
    self.animationState = STARTING;
    _count = 0;
    self.hidden = NO;
    [self update];
}

-(void)stopAnimating {
    if(!self.isAnimating) return;
    self.animationState = SHOULD_END;
}

-(void)trueStopAnimating {
    if(self.hidesWhenStopped) {
        self.hidden = YES;
    }
    
    self.animationState = NOT_RUNNING;
}

-(BOOL)isAnimating {
    return self.animationState == STARTING || self.animationState == RUNNING;
}

-(void)update {
    if(self.animationState == NOT_RUNNING) return;
    
    _count++;
    
    NSInteger framesPerCycle = CYCLE_LENGTH / CYCLE_FRAME;
    
    if(_count > framesPerCycle) {  // reset the animation
        if(self.animationState == STARTING) {
            self.animationState = RUNNING;
        }
        
        if(self.animationState == ENDING) {
            [self trueStopAnimating];
            return;
        }
        
        if(self.animationState == SHOULD_END) {
            self.animationState = ENDING;
        }
        
        _count = 0;
    }
    
    int countPerBar = (framesPerCycle / 1.3) / [_bars count];
    float barHeight = self.frame.size.height;
    float statelessMinBarHeight = self.frame.size.height / 1.5;
    
    for(int i = 0; i < [_bars count]; i++) {
        int startingCount = i * (countPerBar/2);
        int endingCount = startingCount + countPerBar;
        int centerPoint = (endingCount - startingCount) / 2 + startingCount;
        
        float perc = 0.0;
        if(_count >= startingCount && _count <= endingCount) {
            perc = 1.0 - ABS(_count - centerPoint) / (((float)endingCount - (float)startingCount) / 2.0);
        }
        
        UIView *leaf = [_bars objectAtIndex:i];
        
        // Adjust the height of the collapsed bar IF we are starting or ending an animation
        float minBarHeight = statelessMinBarHeight;
        if((self.animationState == STARTING && _count < centerPoint) ||
           (self.animationState == ENDING && _count >= centerPoint)) {
            minBarHeight = NOT_RUNNING_BAR_HEIGHT;
        }
        
        leaf.frame = CGRectMake(leaf.frame.origin.x,
                                [self interpolate:barHeight - minBarHeight end:0 perc:perc],
                                leaf.frame.size.width,
                                [self interpolate:minBarHeight end:barHeight perc:perc]);

        leaf.alpha = MAX(1.0/perc, 0.8);
    }
    
    __block __weak __typeof(self) weakSelf = self;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CYCLE_FRAME * NSEC_PER_SEC));
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        typeof(self) strongSelf = weakSelf;
        [strongSelf update];
    });
}

#pragma mark - Setters
-(void)setColor:(UIColor *)color {
    _color = color;
    for (UIView *bar in _bars) {
        bar.backgroundColor = color;
    }
}

#pragma mark - Setup Shape Layers
-(void)setupIndicator {
    // Defaults
    self.hidden = YES;
    self.backgroundColor = [UIColor clearColor];
    _color = [UIColor colorWithRed:99.0 / 256.0 green:146.0 / 256.0 blue:198.0 / 256.0 alpha:1.0];
    self.hidesWhenStopped = YES;
    
    float fullBarWidth = self.frame.size.width / 3.0;
    float barWidth = (2.0 * fullBarWidth) / 3.0;
    
    NSMutableArray *bars = [NSMutableArray arrayWithCapacity:3];
    CGFloat x = 0;
    for(int i = 0; i < 3; i++) {
        UIView *bar = [[UIView alloc] initWithFrame:CGRectMake(x, 0, barWidth, self.frame.size.height)];
        
        bar.backgroundColor = _color;
        
        x += fullBarWidth;

        [self addSubview:bar];
        [bars addObject:bar];
    }
    
    _bars = [NSArray arrayWithArray:bars];
}

-(float)interpolate:(float)start end:(float)end perc:(float)perc {
    return (end - start) * perc + start;
}
@end
