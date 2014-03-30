//
//  UIViewController+Additions.h
//  UIViewControllerAdditions
//
//  Created by Henry on 14-3-22.
//  Copyright (c) 2014年 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLConst.h"
#import <objc/runtime.h>
#import "MBProgressHUD.h"

@interface UIViewController (Additions)

@property (nonatomic,strong) MBProgressHUD *hud;

- (void)async:(void(^)(void))block;
- (void)async_main:(void(^)(void))block;

/*
 Simple wrap of MBProgressHUD
 */
- (void)showHUD;
- (void)hideHUD;
- (void)showHUDNoAnimate;
- (void)showHUDWithOvertime;
- (void)showHUDWithText:(NSString *)aText;
- (void)showHUDSuccess:(NSString *)sucessString;
- (void)showHUDFailed:(NSString *)failedString;
- (void)hideHUDWithFailure;
- (void)showHUDAutoDismiss:(NSString *)string;
- (void)showHUDSuccessAutoDismiss:(NSString *)sucessString;
- (void)showHUDFailedAutoDismiss:(NSString *)failedInfo;


/*
 Simple wrap of UIBarbuttonItem With Custom Button combining iOS7 and iOS6.
 */

- (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)selector;
- (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)selector color:(UIColor *)titleColor;
- (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)selector;
- (void)addBarButtonItemTo:(UINavigationItem *)navigationItem withImage:(UIImage *)image target:(id)target action:(SEL)selector left:(BOOL)left autoMargin:(BOOL)ifMargin;
- (void)addBarButtonItemTo:(UINavigationItem *)navigationItem withImage:(UIImage *)image target:(id)target action:(SEL)selector left:(BOOL)left margin:(CGFloat)margin;

/*
 Simplified title view.
 */
- (UILabel *)titleLabelWhiteColor:(NSString *)title;
- (UILabel *)titleLabelWhiteColor:(NSString *)title fontSize:(CGFloat)fontSize;
- (UILabel *)titleLabelWhiteColor:(NSString *)title fontSize:(CGFloat)fontSize bold:(BOOL)bold;
- (UILabel *)titleLabelTitle:(NSString *)title fontSize:(CGFloat)fontSize bold:(BOOL)bold color:(UIColor *)color;

@end
