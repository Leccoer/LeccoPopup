//
//  LeccoPopupViewAnimationSlide.h
//  LeccoPopupDemo
//
//  Created by yixin on 2018/12/7.
//  Copyright © 2018 yixin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController+LeccoPopupViewController.h"

typedef NS_ENUM(NSUInteger, LeccoPopupViewAnimationSlideType) {
    LeccoPopupViewAnimationSlideTypeBottomTop,
    LeccoPopupViewAnimationSlideTypeBottomBottom,
    LeccoPopupViewAnimationSlideTypeTopTop,
    LeccoPopupViewAnimationSlideTypeTopBottom,
    LeccoPopupViewAnimationSlideTypeLeftLeft,
    LeccoPopupViewAnimationSlideTypeLeftRight,
    LeccoPopupViewAnimationSlideTypeRightLeft,
    LeccoPopupViewAnimationSlideTypeRightRight,
};


NS_ASSUME_NONNULL_BEGIN

@interface LeccoPopupViewAnimationSlide : NSObject<LeccoPopupAnimation>
@property (nonatomic,assign)LeccoPopupViewAnimationSlideType type;
@end

NS_ASSUME_NONNULL_END
