//
//  GameWorldsTableViewController.m
//  xyrality-test
//
//  Created by Agapov Oleg on 22.08.16.
//  Copyright © 2016 Agapov Oleg. All rights reserved.
//

#import "GameWorldsTableViewController.h"

@implementation GameWorldsTableViewController

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.gameWorlds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameWorldsReuseIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = self.gameWorlds[[indexPath indexAtPosition:1]];
    return cell;
}

@end
