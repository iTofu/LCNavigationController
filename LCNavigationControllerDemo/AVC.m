//
//  AVC.m
//  LCNavigationControllerDemo
//
//  Created by Leo on 15/11/24.
//  Copyright © 2015年 Leo. All rights reserved.
//

#import "AVC.h"
#import "LCNavigationController.h"
#import "BVC.h"

@interface AVC ()

@end

@implementation AVC

- (IBAction)push {
    
    BVC *bVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BVC"];
    [self.lcNavigationController pushViewController:bVC];
}

@end
