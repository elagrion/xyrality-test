//
//  Backend.m
//  xyrality-test
//
//  Created by Agapov Oleg on 16.08.16.
//  Copyright © 2016 Agapov Oleg. All rights reserved.
//

#import "Backend.h"

static NSString* GameWorldsRequestURLString = @"http://backend1.lordsandknights.com/XYRALITY/WebObjects/BKLoginServer.woa/wa/worlds";


@interface Backend()

@property (strong) NSURLSession *session;

@end

@implementation Backend

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return self;
}

- (void)requestGameWorldsWithLogin:(NSString *)login password:(NSString *)password success:(void (^)(NSArray* worlds))successBlock failure:(void (^)(NSError* error))failureBlock {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.gameWorldsRequestURL];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [self gameWorldsRequestBodyWithLogin:login password:password];

    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request
                                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            if (successBlock != nil) {
                NSArray *worlds = [self processGamesWorldResponse:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    successBlock(worlds);
                });
            }
        }
        else {
            if (failureBlock != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    failureBlock(error);
                });
            }
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

- (NSArray *)processGamesWorldResponse:(NSData* )data {
    NSDictionary* dict = [NSPropertyListSerialization propertyListWithData:data options:0 format:nil error:nil];
    NSArray *gameWorlds = [dict[@"allAvailableWorlds"] valueForKey:@"name"];
    return gameWorlds;
}


@end
