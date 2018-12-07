//
//  UIViewController+LeccoPopupViewController.h
//  LeccoPopupDemo
//
//  Created by yixin on 2018/12/7.
//  Copyright © 2018 yixin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LeccoPopupAnimation <NSObject>
@required
- (void)showView:(UIView*)popupView overlayView:(UIView*)overlayView;
- (void)dismissView:(UIView*)popupView overlayView:(UIView*)overlayView completion:(void (^)(void))completion;

@end

@interface UIViewController (LeccoPopupViewController)
@property (nonatomic, retain, readonly) UIView *LeccoPopupView;
@property (nonatomic, retain, readonly) UIView *LeccoOverlayView;
@property (nonatomic, retain, readonly) id<LeccoPopupAnimation> LeccoPopupAnimation;

// default click background to disappear
- (void)Lecco_presentPopupView:(UIView *)popupView animation:(id<LeccoPopupAnimation>)animation;
- (void)Lecco_presentPopupView:(UIView *)popupView animation:(id<LeccoPopupAnimation>)animation dismissed:(void(^)(void))dismissed;

- (void)Lecco_presentPopupView:(UIView *)popupView animation:(id<LeccoPopupAnimation>)animation backgroundClickable:(BOOL)clickable;
- (void)Lecco_presentPopupView:(UIView *)popupView animation:(id<LeccoPopupAnimation>)animation backgroundClickable:(BOOL)clickable dismissed:(void(^)(void))dismissed;

- (void)Lecco_dismissPopupView;
- (void)Lecco_dismissPopupViewWithanimation:(id<LeccoPopupAnimation>)animation;
@end

#pragma mark -
@interface UIView (LeccoPopupViewController)
@property (nonatomic, weak, readonly) UIViewController *LeccoPopupViewController;

@end

NS_ASSUME_NONNULL_END
