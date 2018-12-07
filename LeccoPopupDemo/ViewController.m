//
//  ViewController.m
//  LeccoPopupDemo
//
//  Created by yixin on 2018/12/7.
//  Copyright © 2018 yixin. All rights reserved.
//

#import "ViewController.h"
#import "LeccoPopup.h"
#import "TestPopupView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)showButtonPressed:(id)sender {
    TestPopupView *testView = [[[NSBundle mainBundle]loadNibNamed:@"TestPopupView" owner:nil options:nil] firstObject];
    testView.dismiss = ^{
        [self Lecco_dismissPopupView];
    };
    
    LeccoPopupViewAnimationSlide *animation = [[LeccoPopupViewAnimationSlide alloc]init];
    animation.type = LeccoPopupViewAnimationSlideTypeBottomBottom;
    [self Lecco_presentPopupView:testView animation:[LeccoPopupViewAnimationDrop new]];
    
}


@end
