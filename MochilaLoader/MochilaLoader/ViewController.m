//
//  ViewController.m
//  MochilaLoader
//
//  Created by Andrew Zimmer on 2/5/15.
//  Copyright (c) 2015 AndrewZimmer. All rights reserved.
//

#import "ViewController.h"
#import "AZActivityIndicator.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet AZActivityIndicator *activity;

@property (weak, nonatomic) IBOutlet UIButton *showBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [_activity start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showClicked:(id)sender {
    if(_activity.isHidden) {
        [_activity startAnimating];
        [_showBtn setTitle:@"Hide Activity Indicator" forState:UIControlStateNormal];
    } else {
        [_activity stopAnimating];
        [_showBtn setTitle:@"Show Activity Indicator" forState:UIControlStateNormal];
    }
}

@end
