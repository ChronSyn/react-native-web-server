//
//  WebServer.m
//  ReactNativeWebServer
//
//  Created by Hemanta Sapkota on 20/7/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTConvert.h>
#import <React/RCTLog.h>
#import "AppWebServer.h"

#import <Webserver/Webserver.h>

@implementation AppWebServer

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(start:(NSString *)fileDir done:(RCTResponseSenderBlock)callback)
{
  RCTLogInfo(@"AppWebServer Native Moudle - start");
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    WebserverSetConfig(fileDir, true);
    NSError *error = nil;
    NSString* url = WebserverStart(&error);
    callback(@[url]);
  });
}

RCT_EXPORT_METHOD(stop)
{
  RCTLogInfo(@"AppWebServer Native Moudle - stop");
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    WebserverStop();
  });
}

RCT_REMAP_METHOD(isRunning, isRunningWithResolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    BOOL running = WebserverIsRunning();
    RCTLogInfo(@"AppWebServer Native Moudle - isRunning %d", running);
    resolve(running ? @"true" : @"false");
  });
}

RCT_REMAP_METHOD(serverUrl, serverUrlWithResolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    NSString* serverUrl = WebserverServerUrl();
    RCTLogInfo(@"AppWebServer Native Moudle - serverUrl %@", serverUrl);
    resolve(serverUrl);
  });
}

@end
