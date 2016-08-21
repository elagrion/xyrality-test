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
    [self.backend requestGameWorldsWithLogin:login password:password completion:^(NSData *data) {
        [self showGameWorldsListViewControllerWithWorlds:[self processResponse:data]];
    }];
}

- (void)showGameWorldsListViewControllerWithWorlds:(NSArray *)gameWorlds {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GameWorldsTableViewController *gameWorldsViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"GameWorldsTableViewController"];
    gameWorldsViewController.gameWorlds  = gameWorlds;
    [self showViewController:gameWorldsViewController sender:nil];
}

- (NSArray *)processResponse:(NSData* )data {
    NSDictionary* dict = [NSPropertyListSerialization propertyListWithData:data options:0 format:nil error:nil];
    NSArray *gameWorlds = [dict[@"allAvailableWorlds"] valueForKey:@"name"];
    return gameWorlds;
}

@end
