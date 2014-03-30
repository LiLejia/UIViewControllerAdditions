//
//  UIViewController+Additions.m
//  UIViewControllerAdditions
//
//  Created by Henry on 14-3-22.
//  Copyright (c) 2014年 Henry. All rights reserved.
//

#import "UIViewController+Additions.h"

@implementation UIViewController (Additions)

#pragma mark - ASync

- (void)async:(void(^)(void))block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

- (void)async_main:(void(^)(void))block{
    dispatch_async(dispatch_get_main_queue(), block);
}

ADD_DYNAMIC_PROPERTY(MBProgressHUD*,hud,setHud)

#pragma mark - HUD

- (void)showHUD{
    if(!self.hud){
        if(self.navigationController.view){ 
            self.hud = [[MBProgressHUD alloc]initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:self.hud];
        }
    }
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.customView = nil;
    self.hud.labelText = nil;
    [self.hud show:YES];
}

- (void)showHUDNoAnimate{
    if(!self.hud){
        if(self.navigationController.view){
            self.hud = [[MBProgressHUD alloc]initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:self.hud];
        }
    }
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.customView = nil;
    self.hud.labelText = nil;
    [self.hud show:YES];
}

- (void)showHUDSuccess:(NSString *)sucessString{
    
    if(!self.hud){
        if(self.navigationController.view){
            self.hud = [[MBProgressHUD alloc]initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:self.hud];
        }else{
            self.hud = [[MBProgressHUD alloc]initWithView:self.view];
            [self.view addSubview:self.hud];
        }
    }
    
    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hud-done"]];
    self.hud.labelText = sucessString;
    [self.hud show:YES];
}

- (void)showHUDFailed:(NSString *)failedString{
    
    if(!self.hud){
        if(self.navigationController.view){ 
            self.hud = [[MBProgressHUD alloc]initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:self.hud];
        }else{
            self.hud = [[MBProgressHUD alloc]initWithView:self.view];
            [self.view addSubview:self.hud];
        }
    }
    
    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hud-failed"]];
    self.hud.labelText = failedString;
    [self.hud show:YES];
}

- (void)showHUDWithOvertime{
    [self showHUD];
    [self performSelector:@selector(hideHUDWithFailure) withObject:nil afterDelay:29.0];
}

- (void)hideHUDWithFailure{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.hud){
            self.hud.labelText = @"Load failed";
            [self.hud hide:YES afterDelay:1.0];
        }});
}

- (void)hideHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.hud hide:YES];
        [self.hud removeFromSuperview];
        self.hud.mode = MBProgressHUDModeIndeterminate;
        self.hud = nil;
    });
}

- (void)showHUDWithText:(NSString *)aText{
    if(!self.hud){
        self.hud = [[MBProgressHUD alloc]initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:self.hud];
    }
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.customView = nil;
    self.hud.labelText = aText;
    [self.hud show:YES];
}

- (void)showHUDFailedAutoDismiss:(NSString *)failedInfo{
    [self showHUDFailed:failedInfo];
    [self performSelector:@selector(hideHUD) withObject:nil afterDelay:0.75];
}

- (void)showHUDSuccessAutoDismiss:(NSString *)sucessString{
    [self showHUDSuccess:sucessString];
    [self performSelector:@selector(hideHUD) withObject:nil afterDelay:0.75];
}

- (void)showHUDAutoDismiss:(NSString *)string{
    if(!self.hud){
        self.hud = [[MBProgressHUD alloc]initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:self.hud];
    }
    self.hud.mode = MBProgressHUDModeText;
    self.hud.customView = nil;
    self.hud.labelText = string;
    [self.hud show:YES];
    [self performSelector:@selector(hideHUD) withObject:nil afterDelay:1.0];
}

#pragma mark - UIBarButton

- (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)selector{
    return [self barButtonItemWithTitle:title target:target action:selector color:nil];
}

- (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)selector color:(UIColor *)titleColor{
    if(iOS7_ABOVE){
        return [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:target action:selector];
    }else{
        UIButton *nextStep = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextStep setTitle:title forState:UIControlStateNormal];
        if(titleColor)
            [nextStep setTitleColor:titleColor forState:UIControlStateNormal];
        [nextStep addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        nextStep.titleLabel.font = [UIFont systemFontOfSize:15.0];
        nextStep.frame = CGRectMake(0, 0, 60, 40);
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:nextStep];
        return barButtonItem;
    }
}

- (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)selector{
    
    if(iOS7_ABOVE){
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:target action:selector];
        return barButtonItem;
    }else{
        UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [barButton setImage:image forState:UIControlStateNormal];
        [barButton setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [barButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *customBarButton = [[UIBarButtonItem alloc]initWithCustomView:barButton];
        return customBarButton;
    }
}

- (void)addBarButtonItemTo:(UINavigationItem *)navigationItem withImage:(UIImage *)image target:(id)target action:(SEL)selector
                      left:(BOOL)left
                autoMargin:(BOOL)ifMargin{
    if(ifMargin){
        [self addBarButtonItemTo:navigationItem withImage:image target:target action:selector left:left margin:-10];
    }else{
        [self addBarButtonItemTo:navigationItem withImage:image target:target action:selector left:left margin:0];
    }
}

- (void)addBarButtonItemTo:(UINavigationItem *)navigationItem withImage:(UIImage *)image target:(id)target action:(SEL)selector left:(BOOL)left margin:(CGFloat)margin{
    UIBarButtonItem *barButton = [self barButtonItemWithImage:image target:target action:selector];
    if(iOS7_ABOVE){
            UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
            spaceButton.width = margin;
            if(left)
                navigationItem.leftBarButtonItems = @[spaceButton,barButton];
            else
                navigationItem.rightBarButtonItems = @[spaceButton,barButton];
            return;
    }
    if(left)
        navigationItem.leftBarButtonItem = barButton;
    else
        navigationItem.rightBarButtonItem = barButton;
}


#pragma mark - Title Label

- (UILabel *)titleLabelWhiteColor:(NSString *)title{
    return [self titleLabelWhiteColor:title fontSize:20.0];
}

- (UILabel *)titleLabelWithTitle:(NSString *)title color:(UIColor *)titleColor{
    return [self titleLabelTitle:title fontSize:20.0 bold:YES color:titleColor];
}

- (UILabel *)titleLabelWhiteColor:(NSString *)title fontSize:(CGFloat)fontSize{

    return [self titleLabelWhiteColor:title fontSize:fontSize bold:YES];
}

- (UILabel *)titleLabelWhiteColor:(NSString *)title fontSize:(CGFloat)fontSize bold:(BOOL)bold{
    return [self titleLabelTitle:title fontSize:fontSize bold:bold color:[UIColor whiteColor]];
}

- (UILabel *)titleLabelTitle:(NSString *)title fontSize:(CGFloat)fontSize bold:(BOOL)bold color:(UIColor *)color{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200.0, 44.0)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = color;
    label.textAlignment = NSTextAlignmentCenter;
    if(bold)
        label.font = [UIFont boldSystemFontOfSize:fontSize];
    else
        label.font = [UIFont systemFontOfSize:fontSize];
    label.text = title;
    return label;
}

@end
