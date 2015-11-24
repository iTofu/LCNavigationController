//
//  BVC.m
//  LCNavigationControllerDemo
//
//  Created by Leo on 15/11/24.
//  Copyright © 2015年 Leo. All rights reserved.
//

#import "BVC.h"
#import "LCNavigationController.h"

@interface BVC ()

@end

@implementation BVC

- (IBAction)pop {
    
    [self.lcNavigationController popViewController];
}

@end
