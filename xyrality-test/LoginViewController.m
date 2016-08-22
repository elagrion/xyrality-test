//
//  ViewController.m
//  xyrality-test
//
//  Created by Agapov Oleg on 14.08.16.
//  Copyright © 2016 Agapov Oleg. All rights reserved.
//

#import "LoginViewController.h"
#import "Backend.h"
#import "GameWorldsTableViewController.h"

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
    NSString *login =  self.loginField.text;
    NSString *password = self.passwordField.text;
    [self.backend requestGameWorldsWithLogin:login password:password success:^(NSArray *worlds) {
        [self showGameWorldsListViewControllerWithWorlds:worlds];
    } failure:^(NSError *error) {
        [self showError:error];
    }];
}

- (void)showGameWorldsListViewControllerWithWorlds:(NSArray *)gameWorlds {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GameWorldsTableViewController *gameWorldsViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"GameWorldsTableViewController"];
    gameWorldsViewController.gameWorlds  = gameWorlds;
    [self showViewController:gameWorldsViewController sender:nil];
}

- (void)showError:(NSError *)error {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Oh Snap!"
                                                                   message:error.localizedDescription
                                                            preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [alert dismissViewControllerAnimated:YES completion:nil];
                                                          }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];}

@end
