//
//  RSForgotPasswordViewController.m
//  RideShare
//
//  Created by Reddy on 22/01/16.
//  Copyright © 2016 Reddy. All rights reserved.
//

#import "RSForgotPasswordViewController.h"
#import "RSConstants.h"
#import "RSUtils.h"
#import "RSServices.h"
#import "AppDelegate.h"

@interface RSForgotPasswordViewController ()

@end

@implementation RSForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submitAction:(id)sender
{
   if ([RSUtils isValidEmail:_emailInput.text])
   {
       [appDelegate showLoaingWithTitle:nil];
       [RSServices processForgotPassword:@{@"email" : _emailInput.text} completionHandler:^(NSDictionary * response, NSError * error)
        {
            [appDelegate hideLoading];
            NSString *alertMsg = nil;
            if (error != nil)
            {
                alertMsg = error.description;
            }
            else if (response != nil)
            {
                if ([[response objectForKey:kResponseCode] intValue] == kRequestSuccess)
                {
                    //NSLog(@"Login success! with info: %@", response);
                    
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                    {
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                    [RSUtils showAlertWithTitle:@"Forgot Password" message:@"New password has been sent to your email." actionOne:okAction actionTwo:nil inView:self];
                }
                else
                {
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                    
                    [RSUtils showAlertWithTitle:@"Forgot Password" message:[response objectForKey:kResponseMessage] actionOne:okAction actionTwo:nil inView:self];
                    return;
                }
            }
            if (alertMsg.length != 0)
            {
                [RSUtils showAlertWithTitle:@"Forgot Password" message:alertMsg actionOne:nil actionTwo:nil inView:self];
            }
        }];
   }
    else
    {
        [RSUtils showAlertWithTitle:@"Forgot Password" message:@"Please enter valid email." actionOne:nil actionTwo:nil inView:self];
    }
}

@end
