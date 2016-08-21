//
//  Backend.m
//  xyrality-test
//
//  Created by Agapov Oleg on 16.08.16.
//  Copyright © 2016 Agapov Oleg. All rights reserved.
//

#import "Backend.h"

static NSString* GameWorldsRequestURLString = @"http://backend1.lordsandknights.com/XYRALITY/WebObjects/BKLoginServer.woa/wa/worlds";

@implementation Backend

- (void)requestGameWorldsWithLogin:(NSString *)login password:(NSString *)password completion:(void (^)(NSData* data))completionBlock {
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.gameWorldsRequestURL];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [self gameWorldsRequestBodyWithLogin:login password:password];

    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil && completionBlock != nil) {
            completionBlock(data);
        }
    }];

    [task resume];
}

- (NSURL *)gameWorldsRequestURL {
    return [NSURL URLWithString:GameWorldsRequestURLString];
}

- (NSData *)gameWorldsRequestBodyWithLogin:(NSString *)login password:(NSString *)password {
    NSMutableData *requestBody = [NSMutableData new];
    NSString *loginRequestString = [NSString stringWithFormat:@"login=%@", login];
    [requestBody appendData:[loginRequestString dataUsingEncoding:NSUTF8StringEncoding]];

    NSString *passRequestString = [NSString stringWithFormat:@"&password=%@", password];
    [requestBody appendData:[passRequestString dataUsingEncoding:NSUTF8StringEncoding]];

    NSString *deviceType = [NSString stringWithFormat:@"%@ - %@ %@", [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion]];
    NSString *deviceTypeRequestString = [NSString stringWithFormat:@"&deviceType=%@", deviceType];
    [requestBody appendData:[deviceTypeRequestString dataUsingEncoding:NSUTF8StringEncoding]];

    NSString *deviceIdRequestString = [NSString stringWithFormat:@"&deviceId=%@", [[NSUUID UUID] UUIDString]];
    [requestBody appendData:[deviceIdRequestString dataUsingEncoding:NSUTF8StringEncoding]];

    return [requestBody copy];
}

@end
