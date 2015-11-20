//
//  ThreeVC.m
//  LCNavigationControllerDemo
//
//  Created by Leo on 15/11/20.
//  Copyright © 2015年 Leo. All rights reserved.
//

#import "ThreeVC.h"
#import "LCNavigationController.h"

@interface ThreeVC ()

@end

@implementation ThreeVC

- (IBAction)popBtnClicked {
    
    [self.lcNavigationController popViewController];
}

- (IBAction)popToRootBtnClicked {
    
    [self.lcNavigationController popToRootViewController];
}

@end
