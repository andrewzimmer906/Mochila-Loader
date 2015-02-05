//
//  AZClockView.m
//  Mochilla
//
//  Created by Andrew Zimmer on 10/11/12.
//  Copyright (c) 2012 Mochila. All rights reserved.
//

#import "AZClockView.h"
@interface AZClockView()
    -(void)setup;
@end
@implementation AZClockView
/*
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

-(void)setup {
    clockLayer_ = [CAShapeLayer layer];
    clockLayer_.strokeColor = [[UIColor colorWithHex:@"#394552"] CGColor];
    clockLayer_.fillColor = [[UIColor whiteColor] CGColor];
    clockLayer_.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.width, self.height)].CGPath;
    
    centerCircleLayer_ = [CAShapeLayer layer];
    centerCircleLayer_.fillColor = [[UIColor colorWithHex:@"#394552"] CGColor];
    centerCircleLayer_.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.width/2-0.5, self.height/2-0.5, 1, 1)].CGPath;
    [clockLayer_ addSublayer:centerCircleLayer_];
    
    hourHand_ = [CAShapeLayer layer];
    hourHand_.strokeColor = [[UIColor colorWithHex:@"#394552"] CGColor];
    [clockLayer_ addSublayer:hourHand_];
    
    minuteHand_ = [CAShapeLayer layer];
    minuteHand_.strokeColor = [[UIColor colorWithHex:@"#394552"] CGColor];
    [clockLayer_ addSublayer:minuteHand_];
    
    [self.layer addSublayer:clockLayer_];
}

#pragma mark - Drawing
-(void)drawForDate:(NSDate*)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    
    CGPoint centerPoint = CGPointMake((float)self.width/2, (float)self.height/2);

    float hourLength = 3;
    float hourAngle = (M_PI_2) + (hour*(M_PI/6));
    CGMutablePathRef hourPath = nil;
    hourPath = CGPathCreateMutable();
    CGPathMoveToPoint(hourPath, NULL, centerPoint.x, centerPoint.y);
    CGPathAddLineToPoint(hourPath, NULL, centerPoint.x - hourLength * cosf(hourAngle), centerPoint.y - hourLength * sinf(hourAngle));
    hourHand_.path = hourPath;
    CGPathRelease(hourPath);
    
    float minuteLength = 3.5;
    float minuteAngle = (M_PI_2) + (minute*(M_PI/30));
    CGMutablePathRef minutePath = nil;
    minutePath = CGPathCreateMutable();
    CGPathMoveToPoint(minutePath, NULL, centerPoint.x, centerPoint.y);
    CGPathAddLineToPoint(minutePath, NULL, centerPoint.x - minuteLength * cosf(minuteAngle), centerPoint.y - minuteLength * sinf(minuteAngle));
    minuteHand_.path = minutePath;
    CGPathRelease(minutePath);
}

*/
@end
