//
//  SplashController.m
//  INGMovie
//
//  Created by Bahriye Begüm on 6.04.2020.
//  Copyright © 2020 INGMovie. All rights reserved.
//

#import "SplashController.h"

@interface SplashController ()

@end

@implementation SplashController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSelector:@selector(showHomePage) withObject:nil afterDelay:1.0];
}

-(void)showHomePage{
    UINavigationController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"navigationController"];
    [self presentViewController:controller animated:YES completion:nil];
}








@end
