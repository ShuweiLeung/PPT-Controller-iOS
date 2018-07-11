//
//  ViewController.h
//  SocketMac
//
//  Created by 汪鑫源 on 16/2/12.
//  Copyright © 2016年 汪鑫源. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@import CocoaAsyncSocket;

@interface ViewController : NSViewController <GCDAsyncSocketDelegate>

@property(nonatomic, strong) GCDAsyncSocket *socket;
@property (strong, nonatomic) IBOutlet NSTextField *ipAddressLabel;

@end

