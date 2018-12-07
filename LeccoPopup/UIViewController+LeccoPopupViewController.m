//
//  UIViewController+LeccoPopupViewController.m
//  LeccoPopupDemo
//
//  Created by yixin on 2018/12/7.
//  Copyright © 2018 yixin. All rights reserved.
//

#import "UIViewController+LeccoPopupViewController.h"
#import <objc/runtime.h>
#import "LeccoPopupBackgroundView.h"


#define kLeccoPopupView @"kLeccoPopupView"
#define kLeccoOverlayView @"kLeccoOverlayView"
#define kLeccoPopupViewDismissedBlock @"kLeccoPopupViewDismissedBlock"
#define KLeccoPopupAnimation @"KLeccoPopupAnimation"
#define kLeccoPopupViewController @"kLeccoPopupViewController"

#define kLeccoPopupViewTag 8002
#define kLeccoOverlayViewTag 8003

@interface UIView (LeccoPopupViewControllerPrivate)
@property (nonatomic, weak, readwrite) UIViewController *LeccoPopupViewController;
@end

@interface UIViewController (LeccoPopupViewControllerPrivate)
@property (nonatomic, retain) UIView *LeccoPopupView;
@property (nonatomic, retain) UIView *LeccoOverlayView;
@property (nonatomic, copy) void(^LeccoDismissCallback)(void);
@property (nonatomic, retain) id<LeccoPopupAnimation> popupAnimation;
- (UIView*)topView;
@end

@implementation UIViewController (LeccoPopupViewController)

#pragma public method

- (void)Lecco_presentPopupView:(UIView *)popupView animation:(id<LeccoPopupAnimation>)animation{
    [self _presentPopupView:popupView animation:animation backgroundClickable:YES dismissed:nil];
}

- (void)Lecco_presentPopupView:(UIView *)popupView animation:(id<LeccoPopupAnimation>)animation dismissed:(void (^)(void))dismissed{
    [self _presentPopupView:popupView animation:animation backgroundClickable:YES dismissed:dismissed];
}

- (void)Lecco_presentPopupView:(UIView *)popupView animation:(id<LeccoPopupAnimation>)animation backgroundClickable:(BOOL)clickable{
    [self _presentPopupView:popupView animation:animation backgroundClickable:clickable dismissed:nil];
}

- (void)Lecco_presentPopupView:(UIView *)popupView animation:(id<LeccoPopupAnimation>)animation backgroundClickable:(BOOL)clickable dismissed:(void (^)(void))dismissed{
    [self _presentPopupView:popupView animation:animation backgroundClickable:clickable dismissed:dismissed];
}

- (void)Lecco_dismissPopupViewWithanimation:(id<LeccoPopupAnimation>)animation{
    [self _dismissPopupViewWithAnimation:animation];
}

- (void)Lecco_dismissPopupView{
    [self _dismissPopupViewWithAnimation:self.LeccoPopupAnimation];
}
#pragma mark - inline property
- (UIView *)LeccoPopupView {
    return objc_getAssociatedObject(self, kLeccoPopupView);
}

- (void)setLeccoPopupView:(UIViewController *)LeccoPopupView {
    objc_setAssociatedObject(self, kLeccoPopupView, LeccoPopupView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)LeccoOverlayView{
    return objc_getAssociatedObject(self, kLeccoOverlayView);
}

- (void)setLeccoOverlayView:(UIView *)LeccoOverlayView {
    objc_setAssociatedObject(self, kLeccoOverlayView, LeccoOverlayView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void(^)(void))LeccoDismissCallback{
    return objc_getAssociatedObject(self, kLeccoPopupViewDismissedBlock);
}

- (void)setLeccoDismissCallback:(void (^)(void))LeccoDismissCallback{
    objc_setAssociatedObject(self, kLeccoPopupViewDismissedBlock, LeccoDismissCallback, OBJC_ASSOCIATION_COPY);
}

- (id<LeccoPopupAnimation>)LeccoPopupAnimation{
    return objc_getAssociatedObject(self, KLeccoPopupAnimation);
}

- (void)setLeccoPopupAnimation:(id<LeccoPopupAnimation>)LeccoPopupAnimation{
    objc_setAssociatedObject(self, KLeccoPopupAnimation, LeccoPopupAnimation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark - view handle

- (void)_presentPopupView:(UIView*)popupView animation:(id<LeccoPopupAnimation>)animation backgroundClickable:(BOOL)clickable dismissed:(void(^)(void))dismissed{
    
    
    // check if source view controller is not in destination
    if ([self.LeccoOverlayView.subviews containsObject:popupView]) return;
    
    // fix issue #2
    if (self.LeccoOverlayView && self.LeccoOverlayView.subviews.count > 1) {
        [self _dismissPopupViewWithAnimation:nil];
    }
    
    self.LeccoPopupView = nil;
    self.LeccoPopupView = popupView;
    self.LeccoPopupAnimation = nil;
    self.LeccoPopupAnimation = animation;
    
    UIView *sourceView = [self _Lecco_topView];
    
    // customize popupView
    popupView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    popupView.tag = kLeccoPopupViewTag;
    popupView.layer.shadowPath = [UIBezierPath bezierPathWithRect:popupView.bounds].CGPath;
    popupView.layer.masksToBounds = NO;
    popupView.layer.shadowOffset = CGSizeMake(5, 5);
    popupView.layer.shadowRadius = 5;
    popupView.layer.shadowOpacity = 0.5;
    popupView.layer.shouldRasterize = YES;
    popupView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    // Add overlay
    if (self.LeccoOverlayView == nil) {
        UIView *overlayView = [[UIView alloc] initWithFrame:sourceView.bounds];
        overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayView.tag = kLeccoOverlayViewTag;
        overlayView.backgroundColor = [UIColor clearColor];
        
        // BackgroundView
        UIView *backgroundView = [[LeccoPopupBackgroundView alloc] initWithFrame:sourceView.bounds];
        backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        backgroundView.backgroundColor = [UIColor clearColor];
        [overlayView addSubview:backgroundView];
        
        // Make the Background Clickable
        if (clickable) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Lecco_dismissPopupView)];
            [backgroundView addGestureRecognizer:tap];
        }
        self.LeccoOverlayView = overlayView;
    }
    
    [self.LeccoOverlayView addSubview:popupView];
    [sourceView addSubview:self.LeccoOverlayView];
    
    self.LeccoOverlayView.alpha = 1.0f;
    popupView.center = self.LeccoOverlayView.center;
    if (animation) {
        [animation showView:popupView overlayView:self.LeccoOverlayView];
    }
    [self setLeccoDismissCallback:dismissed];
    
}

- (void)_dismissPopupViewWithAnimation:(id<LeccoPopupAnimation>)animation{
    if (animation) {
        [animation dismissView:self.LeccoPopupView overlayView:self.LeccoOverlayView completion:^(void) {
            [self.LeccoOverlayView removeFromSuperview];
            [self.LeccoPopupView removeFromSuperview];
            self.LeccoPopupView = nil;
            self.LeccoPopupAnimation = nil;
            
            id dismissed = [self LeccoDismissCallback];
            if (dismissed != nil){
                ((void(^)(void))dismissed)();
                [self setLeccoDismissCallback:nil];
            }
        }];
    }else{
        [self.LeccoOverlayView removeFromSuperview];
        [self.LeccoPopupView removeFromSuperview];
        self.LeccoPopupView = nil;
        self.LeccoPopupAnimation = nil;
        
        id dismissed = [self LeccoDismissCallback];
        if (dismissed != nil){
            ((void(^)(void))dismissed)();
            [self setLeccoDismissCallback:nil];
        }
    }
}

-(UIView*)_Lecco_topView {
    UIViewController *recentView = self;
    
    while (recentView.parentViewController != nil) {
        recentView = recentView.parentViewController;
    }
    return recentView.view;
}

@end

#pragma mark - UIView+LeccoPopupView
@implementation UIView (LeccoPopupViewController)
- (UIViewController *)LeccoPopupViewController {
    return objc_getAssociatedObject(self, kLeccoPopupViewController);
}

- (void)setLeccoPopupViewController:(UIViewController * _Nullable)LeccoPopupViewController {
    objc_setAssociatedObject(self, kLeccoPopupViewController, LeccoPopupViewController, OBJC_ASSOCIATION_ASSIGN);
}
@end

