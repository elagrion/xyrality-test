//
//  ViewController.m
//  xyrality-test
//
//  Created by Agapov Oleg on 14.08.16.
//  Copyright © 2016 Agapov Oleg. All rights reserved.
//

#import "LoginViewController.h"
#import "Backend.h"

@interface LoginViewController ()

@property (nonatomic, weak) IBOutlet UITextField *loginField;
@property (nonatomic, weak) IBOutlet UITextField *passwordField;
@property (nonatomic, strong) Backend *backend;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backend = [Backend new];
}

- (IBAction)doAuth:(id)sender {
    NSString *login =  @"ios.test@xyrality.com"; //self.loginField.text;
    NSString *password = @"password"; //self.passwordField.text;
    [self.backend requestGameWorldsWithLogin:login password:password completion:^(NSData *data) {
        NSString* response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"response: %@", response);
    }];
}

- (void)showWorldListViewController {

}

@end
