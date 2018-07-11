//
//  SimulateKey.h
//  SocketMac
//
//  Created by 汪鑫源 on 16/3/5.
//  Copyright © 2016年 汪鑫源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimulateKey : NSObject

+ (void)play;
+ (void)quit;
+ (void)wakeMouse;
+ (void)next;
+ (void)previous;
+ (void)warpMousePosition:(CGPoint)position;

@end
