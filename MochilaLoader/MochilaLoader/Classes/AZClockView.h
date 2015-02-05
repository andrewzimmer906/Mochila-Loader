//
//  AZClockView.h
//  Mochilla
//
//  Created by Andrew Zimmer on 10/11/12.
//  Copyright (c) 2012 Mochila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface AZClockView : UIView {
    CAShapeLayer *clockLayer_;
    CAShapeLayer *centerCircleLayer_;
    CAShapeLayer *hourHand_;
    CAShapeLayer *minuteHand_;
}

-(void)drawForDate:(NSDate*)date;
@end
