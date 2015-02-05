//
//  AZActivityIndicator.h
//  Mochilla
//
//  Created by Andrew Zimmer on 9/27/12.
//  Copyright (c) 2012 Mochila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface AZActivityIndicator : UIView {
}

-(void)startAnimating;
-(void)stopAnimating;
-(BOOL)isAnimating;

@property(nonatomic) BOOL hidesWhenStopped;
@property(readwrite, nonatomic, strong) UIColor *color;

@end
