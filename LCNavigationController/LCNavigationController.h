//
//  LCNavigationController.h
//  LCNavigationControllerDemo
//
//  Created by Leo on 15/11/20.
//  Copyright © 2015年 Leo. All rights reserved.
//
//  V 1.0.6

#import <UIKit/UIKit.h>


typedef void (^LCNavigationControllerCompletionBlock)(void);


@interface LCNavigationController : UIViewController

@property(nonatomic, strong) NSMutableArray *viewControllers;


- (instancetype)initWithRootViewController:(UIViewController *)rootViewController;


- (void)pushViewController:(UIViewController *)viewController;

- (void)pushViewController:(UIViewController *)viewController
                completion:(LCNavigationControllerCompletionBlock)completion;


- (void)popViewController;

- (void)popViewControllerCompletion:(LCNavigationControllerCompletionBlock)completion;


- (void)popToRootViewController;

- (void)popToViewController:(UIViewController*)toViewController;



@end




@interface UIViewController (LCNavigationController)

@property (nonatomic, strong) LCNavigationController *lcNavigationController;

@end
