//
//  LCNavigationController.m
//  LCNavigationControllerDemo
//
//  Created by Leo on 15/11/20.
//  Copyright © 2015年 Leo. All rights reserved.
//

#import "LCNavigationController.h"

static const CGFloat LCAnimationDuration = 0.50f;   // Push / Pop 动画持续时间
static const CGFloat LCMaxBlackMaskAlpha = 0.80f;   // 黑色背景透明度
static const CGFloat LCZoomRatio         = 0.90f;   // 后面视图缩放比
static const CGFloat LCShadowOpacity     = 0.80f;   // 滑动返回时当前视图的阴影透明度
static const CGFloat LCShadowRadius      = 8.00f;   // 滑动返回时当前视图的阴影半径

typedef enum : NSUInteger {
    PanDirectionNone,
    PanDirectionLeft,
    PanDirectionRight,
} PanDirection;

@interface LCNavigationController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray *gestures;
@property (nonatomic,   weak) UIView *blackMask;
@property (nonatomic, assign) BOOL animationing;
@property (nonatomic, assign) CGPoint panOrigin;
@property (nonatomic, assign) CGFloat percentageOffsetFromLeft;

@end

@implementation LCNavigationController

- (void)dealloc {

    self.viewControllers = nil;
    self.gestures  = nil;
    self.blackMask = nil;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {

    if (self = [super init]) {

        self.viewControllers = [NSMutableArray arrayWithObject:rootViewController];
    }
    return self;
}

- (CGRect)viewBoundsWithOrientation:(UIInterfaceOrientation)orientation {

    CGRect bounds = [UIScreen mainScreen].bounds;

    if ([[UIApplication sharedApplication]isStatusBarHidden]) {

        return bounds;

    } else if (UIInterfaceOrientationIsLandscape(orientation)) {

        CGFloat width = bounds.size.width;
        bounds.size.width = bounds.size.height;
        bounds.size.height = width;

        return bounds;

    } else {

        return bounds;
    }
}

- (void)loadView {

    [super loadView];

    CGRect viewRect = [self viewBoundsWithOrientation:self.interfaceOrientation];

    UIViewController *rootViewController = [self.viewControllers firstObject];
    [rootViewController willMoveToParentViewController:self];
    [self addChildViewController:rootViewController];

    UIView *rootView = rootViewController.view;
    rootView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    rootView.frame = viewRect;
    [self.view addSubview:rootView];
    [rootViewController didMoveToParentViewController:self];

    UIView *blackMask = [[UIView alloc] initWithFrame:viewRect];
    blackMask.backgroundColor = [UIColor blackColor];
    blackMask.alpha = 0;
    blackMask.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view insertSubview:blackMask atIndex:0];
    self.blackMask = blackMask;

    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}

- (UIViewController *)currentViewController {

    UIViewController *result = nil;
    if (self.viewControllers.count) result = [self.viewControllers lastObject];
    return result;
}

- (UIViewController *)previousViewController {

    UIViewController *result = nil;
    if (self.viewControllers.count > 1) {
        result = [self.viewControllers objectAtIndex:self.viewControllers.count - 2];
    }
    return result;
}

- (void)addPanGestureToView:(UIView*)view {

    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(gestureRecognizerDidPan:)];
    panGesture.delegate = self;
    [view addGestureRecognizer:panGesture];
    [self.gestures addObject:panGesture];
}

- (void)gestureRecognizerDidPan:(UIPanGestureRecognizer*)panGesture {

    if (self.animationing) return;

    CGPoint currentPoint = [panGesture translationInView:self.view];
    CGFloat x = currentPoint.x + self.panOrigin.x;

    PanDirection panDirection = PanDirectionNone;
    CGPoint vel = [panGesture velocityInView:self.view];

    if (vel.x > 0) {
        panDirection = PanDirectionRight;
    } else {
        panDirection = PanDirectionLeft;
    }

    CGFloat offset = 0;

    UIViewController *vc = [self currentViewController];
    offset = CGRectGetWidth(vc.view.frame) - x;
    vc.view.layer.shadowColor   = [UIColor blackColor].CGColor;
    vc.view.layer.shadowOpacity = LCShadowOpacity;
    vc.view.layer.shadowRadius  = LCShadowRadius;

    self.percentageOffsetFromLeft = offset / [self viewBoundsWithOrientation:self.interfaceOrientation].size.width;
    vc.view.frame = [self getSlidingRectWithPercentageOffset:self.percentageOffsetFromLeft orientation:self.interfaceOrientation];
    [self transformAtPercentage:self.percentageOffsetFromLeft];

    if (panGesture.state == UIGestureRecognizerStateEnded || panGesture.state == UIGestureRecognizerStateCancelled) {

        if (fabs(vel.x) > 100) {

            [self completeSlidingAnimationWithDirection:panDirection];

        } else {

            [self completeSlidingAnimationWithOffset:offset];
        }
    }
}

- (void)completeSlidingAnimationWithDirection:(PanDirection)direction {

    if (direction == PanDirectionRight){

        [self popViewController];

    } else {

        [self rollBackViewController];
    }
}

- (void)completeSlidingAnimationWithOffset:(CGFloat)offset{

    if (offset < [self viewBoundsWithOrientation:self.interfaceOrientation].size.width * 0.5f) {

        [self popViewController];

    } else {

        [self rollBackViewController];
    }
}

- (void)rollBackViewController {

    self.animationing = YES;

    UIViewController *vc = [self currentViewController];
    UIViewController *nvc = [self previousViewController];
    CGRect rect = CGRectMake(0, 0, vc.view.frame.size.width, vc.view.frame.size.height);

    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{

        CGAffineTransform transf = CGAffineTransformIdentity;
        nvc.view.transform = CGAffineTransformScale(transf, LCZoomRatio, LCZoomRatio);
        vc.view.frame = rect;
        self.blackMask.alpha = LCMaxBlackMaskAlpha;

    } completion:^(BOOL finished) {

        if (finished) {

            self.animationing = NO;
        }
    }];
}

- (CGRect)getSlidingRectWithPercentageOffset:(CGFloat)percentage orientation:(UIInterfaceOrientation)orientation {

    CGRect viewRect = [self viewBoundsWithOrientation:orientation];
    CGRect rectToReturn = CGRectZero;
    rectToReturn.size = viewRect.size;
    rectToReturn.origin = CGPointMake(MAX(0, (1 - percentage) * viewRect.size.width), 0);

    return rectToReturn;
}

- (void)transformAtPercentage:(CGFloat)percentage {

    CGAffineTransform transf = CGAffineTransformIdentity;
    CGFloat newTransformValue =  1 - percentage * (1 - LCZoomRatio);
    CGFloat newAlphaValue = percentage * LCMaxBlackMaskAlpha;
    [self previousViewController].view.transform = CGAffineTransformScale(transf, newTransformValue, newTransformValue);

    self.blackMask.alpha = newAlphaValue;
}

- (void)pushViewController:(UIViewController *)viewController completion:(LCNavigationControllerCompletionBlock)completion {

    self.animationing = YES;


    viewController.view.layer.shadowColor   = [UIColor blackColor].CGColor;
    viewController.view.layer.shadowOpacity = LCShadowOpacity;
    viewController.view.layer.shadowRadius  = LCShadowRadius;

    viewController.view.frame = CGRectOffset(self.view.bounds, self.view.bounds.size.width, 0);
    viewController.view.autoresizingMask =  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.blackMask.alpha = 0;
    [viewController willMoveToParentViewController:self];
    [self addChildViewController:viewController];

    [self.view bringSubviewToFront:self.blackMask];
    [self.view addSubview:viewController.view];

    [UIView animateWithDuration:LCAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{

        CGAffineTransform transf = CGAffineTransformIdentity;
        [self currentViewController].view.transform = CGAffineTransformScale(transf, LCZoomRatio, LCZoomRatio);
        viewController.view.frame = self.view.bounds;
        self.blackMask.alpha = LCMaxBlackMaskAlpha;

    } completion:^(BOOL finished) {

        if (finished) {

            [self.viewControllers addObject:viewController];
            [viewController didMoveToParentViewController:self];

            self.animationing = NO;
            self.gestures = [[NSMutableArray alloc] init];
            [self addPanGestureToView:[self currentViewController].view];

            if (completion != nil) completion();
        }
    }];
}

- (void)pushViewController:(UIViewController *)viewController {

    [self pushViewController:viewController completion:nil];
}

- (void)popViewControllerCompletion:(LCNavigationControllerCompletionBlock)completion {

    if (self.viewControllers.count < 2) return;

    self.animationing = YES;

    UIViewController *currentVC = [self currentViewController];
    UIViewController *previousVC = [self previousViewController];
    [previousVC viewWillAppear:NO];

    currentVC.view.layer.shadowColor   = [UIColor blackColor].CGColor;
    currentVC.view.layer.shadowOpacity = LCShadowOpacity;
    currentVC.view.layer.shadowRadius  = LCShadowRadius;

    [UIView animateWithDuration:LCAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{

        currentVC.view.frame = CGRectOffset(self.view.bounds, self.view.bounds.size.width, 0);
        CGAffineTransform transf = CGAffineTransformIdentity;
        previousVC.view.transform = CGAffineTransformScale(transf, 1.0f, 1.0f);
        previousVC.view.frame = self.view.bounds;
        self.blackMask.alpha = 0;

    } completion:^(BOOL finished) {

        if (finished) {

            [currentVC.view removeFromSuperview];
            [currentVC willMoveToParentViewController:nil];

            [self.view bringSubviewToFront:[self previousViewController].view];
            [currentVC removeFromParentViewController];
            [currentVC didMoveToParentViewController:nil];

            [self.viewControllers removeObject:currentVC];
            self.animationing = NO;
            [previousVC viewDidAppear:NO];

            if (completion != nil) completion();
        }
    }];

}

- (void) popViewController {

    [self popViewControllerCompletion:nil];
}

- (void)popToViewController:(UIViewController*)toViewController {

    NSMutableArray *controllers = self.viewControllers;
    NSInteger index = [controllers indexOfObject:toViewController];
    UIViewController *needRemoveViewController = nil;

    for (int i = (int)controllers.count - 2; i > index; i--) {

        needRemoveViewController = [controllers objectAtIndex:i];
        [needRemoveViewController.view setAlpha:0];

        [needRemoveViewController removeFromParentViewController];
        [controllers removeObject:needRemoveViewController];
    }

    [self popViewController];
}

- (void)popToRootViewController {

    UIViewController *rootController = [self.viewControllers objectAtIndex:0];
    [self popToViewController:rootController];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {

    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {

}

@end




@implementation UIViewController (LCNavigationController)

@dynamic lcNavigationController;

- (LCNavigationController *)lcNavigationController {

    UIResponder *responder = [self nextResponder];

    while (responder) {

        if ([responder isKindOfClass:[LCNavigationController class]]) {

            return (LCNavigationController *)responder;
        }

        responder = [responder nextResponder];
    }

    return nil;
}


@end
