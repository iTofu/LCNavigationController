//
//  OneVC.m
//  LCNavigationControllerDemo
//
//  Created by Leo on 15/11/20.
//  Copyright © 2015年 Leo. All rights reserved.
//

#import "OneVC.h"
#import "LCNavigationController.h"

@interface OneVC ()

@end

@implementation OneVC

- (IBAction)pushBtnClicked {
    
    UIViewController *childVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TwoVC"];
    childVC.hidesBottomBarWhenPushed = YES;
    [self.lcNavigationController pushViewController:childVC];
}

@end
