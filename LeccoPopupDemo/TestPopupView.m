//
//  TestPopupView.m
//  LeccoPopupDemo
//
//  Created by yixin on 2018/12/7.
//  Copyright © 2018 yixin. All rights reserved.
//

#import "TestPopupView.h"

@implementation TestPopupView

- (IBAction)closeButtonPressed:(id)sender {
    if (_dismiss != nil) {
        _dismiss();
    }
}


@end
