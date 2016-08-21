//
//  Backend.h
//  xyrality-test
//
//  Created by Agapov Oleg on 16.08.16.
//  Copyright © 2016 Agapov Oleg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Backend : NSObject

- (void)requestGameWorldsWithLogin:(NSString *)login password:(NSString *)password completion:(void (^__nullable)(NSData *data))completionBlock;

@end
