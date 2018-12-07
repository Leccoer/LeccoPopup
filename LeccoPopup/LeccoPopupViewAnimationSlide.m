//
//  LeccoPopupViewAnimationSlide.m
//  LeccoPopupDemo
//
//  Created by yixin on 2018/12/7.
//  Copyright © 2018 yixin. All rights reserved.
//

#import "LeccoPopupViewAnimationSlide.h"

@implementation LeccoPopupViewAnimationSlide
- (void)showView:(UIView *)popupView overlayView:(UIView *)overlayView{
    
    CGSize sourceSize = overlayView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupStartRect;
    switch (_type) {
        case LeccoPopupViewAnimationSlideTypeBottomTop:
        case LeccoPopupViewAnimationSlideTypeBottomBottom:
            popupStartRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                        sourceSize.height,
                                        popupSize.width,
                                        popupSize.height);
            
            break;
        case LeccoPopupViewAnimationSlideTypeLeftLeft:
        case LeccoPopupViewAnimationSlideTypeLeftRight:
            popupStartRect = CGRectMake(-sourceSize.width,
                                        (sourceSize.height - popupSize.height) / 2,
                                        popupSize.width,
                                        popupSize.height);
            break;
            
        case LeccoPopupViewAnimationSlideTypeTopTop:
        case LeccoPopupViewAnimationSlideTypeTopBottom:
            popupStartRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                        -popupSize.height,
                                        popupSize.width,
                                        popupSize.height);
            break;
            
        default:
            popupStartRect = CGRectMake(sourceSize.width,
                                        (sourceSize.height - popupSize.height) / 2,
                                        popupSize.width,
                                        popupSize.height);
            break;
    }
    CGRect popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                     (sourceSize.height - popupSize.height) / 2,
                                     popupSize.width,
                                     popupSize.height);
    
    // Set starting properties
    popupView.frame = popupStartRect;
    popupView.alpha = 1.0f;
    [UIView animateWithDuration:0.25 delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        popupView.frame = popupEndRect;
    } completion:nil];
    
    
}
- (void)dismissView:(UIView *)popupView overlayView:(UIView *)overlayView completion:(void (^)(void))completion{
    CGSize sourceSize = overlayView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupEndRect;
    switch (_type) {
        case LeccoPopupViewAnimationSlideTypeBottomTop:
        case LeccoPopupViewAnimationSlideTypeTopTop:
            popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                      -popupSize.height,
                                      popupSize.width,
                                      popupSize.height);
            break;
        case LeccoPopupViewAnimationSlideTypeBottomBottom:
        case LeccoPopupViewAnimationSlideTypeTopBottom:
            popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                      sourceSize.height,
                                      popupSize.width,
                                      popupSize.height);
            break;
        case LeccoPopupViewAnimationSlideTypeLeftRight:
        case LeccoPopupViewAnimationSlideTypeRightRight:
            popupEndRect = CGRectMake(sourceSize.width,
                                      popupView.frame.origin.y,
                                      popupSize.width,
                                      popupSize.height);
            break;
        default:
            popupEndRect = CGRectMake(-popupSize.width,
                                      popupView.frame.origin.y,
                                      popupSize.width,
                                      popupSize.height);
            break;
    }
    
    [UIView animateWithDuration:0.25 delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        popupView.frame = popupEndRect;
        overlayView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        completion();
    }];
    
}
@end
