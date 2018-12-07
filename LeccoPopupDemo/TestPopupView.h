//
//  TestPopupView.h
//  LeccoPopupDemo
//
//  Created by yixin on 2018/12/7.
//  Copyright © 2018 yixin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^CalculatorView1Dismiss)();

@interface TestPopupView : UIView

@property (nonatomic, copy) CalculatorView1Dismiss dismiss;


@end

NS_ASSUME_NONNULL_END
