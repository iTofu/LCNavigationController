//
//  TwoVC.m
//  LCNavigationControllerDemo
//
//  Created by Leo on 15/11/20.
//  Copyright © 2015年 Leo. All rights reserved.
//

#import "TwoVC.h"
#import "LCNavigationController.h"

@interface TwoVC ()

@end

@implementation TwoVC

- (IBAction)popBtnClicked {
    
    [self.lcNavigationController popViewController];
}

- (IBAction)pushBtnClicked {
    
    UIViewController *childVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ThreeVC"];
    [self.lcNavigationController pushViewController:childVC];
}

@end
