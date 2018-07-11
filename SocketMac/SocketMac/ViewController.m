//
//  ViewController.m
//  SocketMac
//
//  Created by 汪鑫源 on 16/2/12.
//  Copyright © 2016年 汪鑫源. All rights reserved.
//

#import "ViewController.h"
#import "SimulateKey.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ipAddressLabel.stringValue = [self getIPAddress];
    [self listen];
}

#pragma mark -Private methods
- (void)listen {
    self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error = nil;
    if (![self.socket acceptOnPort:5555 error:&error]) {
        NSLog(@"I goofed: %@", error);
    }
}

- (NSString *)getIPAddress {
    NSArray *ipArray = [[NSHost currentHost] addresses];
    for (NSString *ip in ipArray) {
        if ([self isSeparateByDot:ip] && ![ip isEqualToString:@"127.0.0.1"]) {
            return ip;
        }
    }
    return @"没有分配IP";
}

- (BOOL)isSeparateByDot: (NSString *)string {
    for (NSUInteger i = 0; i < string.length; i++) {
        if ([string characterAtIndex:i] == '.') {
            return YES;
        }
    }
    return NO;
}

- (void)parseReceivedData:(NSData *)data {
    NSString *receivedString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([receivedString isEqualToString:@"L"]) {
        [SimulateKey previous];
    } else if ([receivedString isEqualToString:@"R"]) {
        [SimulateKey next];
    } else if ([receivedString isEqualToString:@"P"]) {
        [SimulateKey play];
    } else if ([receivedString isEqualToString:@"I"]) {
        [SimulateKey wakeMouse];
    } else if ([receivedString isEqualToString:@"Q"]) {
        [SimulateKey quit];
    } else {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if (!dic) {
            NSDictionary *dictionary = (NSDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
            NSDictionary *dic = dictionary[@"file"];
            NSString *fileName = dic[@"name"];
            NSData *fileData = dic[@"data"];
            [self receivedFile:fileData fileName:fileName];
        } else {
            NSNumber *x = (NSNumber *)dic[@"x"];
            NSNumber *y = (NSNumber *)dic[@"y"];
            [SimulateKey warpMousePosition:CGPointMake(x.floatValue, y.floatValue)];
        }
    }
}

- (void)receivedFile:(NSData *)data fileName:(NSString *)fileName {
    NSString *path = [@"/Users/wxy/Desktop" stringByAppendingPathComponent:fileName];
    [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
}

#pragma mark - GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket {
    NSLog(@"New socket:%@", newSocket);
    self.socket = newSocket;
    NSUInteger length = sizeof(NSUInteger);
    [self.socket readDataToLength:length withTimeout:-1 tag:20];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    NSLog(@"Did disconnect!");
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    if (tag == 20) {
        NSUInteger length = 0;
        [data getBytes:&length length:sizeof(NSUInteger)];
        NSMutableData *buffer = [NSMutableData data];
        [self.socket readDataToLength:length withTimeout:-1 buffer:buffer bufferOffset:0 tag:30];
    }
    if (tag == 30) {
        [self parseReceivedData:data];
        [self.socket readDataToLength:sizeof(NSUInteger) withTimeout:-1 tag:20];
    }
}

@end
