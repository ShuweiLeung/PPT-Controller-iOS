//
//  SimulateKey.m
//  SocketMac
//
//  Created by 汪鑫源 on 16/3/5.
//  Copyright © 2016年 汪鑫源. All rights reserved.
//

#import "SimulateKey.h"
#import <AppKit/AppKit.h>
#include <Carbon/Carbon.h>

@implementation SimulateKey

+ (void)play {
    CGEventSourceRef src = CGEventSourceCreate(kCGEventSourceStateHIDSystemState);
    
    CGEventRef cmdd = CGEventCreateKeyboardEvent(src, kVK_Command, true);
    CGEventRef cmdu = CGEventCreateKeyboardEvent(src, kVK_Command, false);
    CGEventRef spcd = CGEventCreateKeyboardEvent(src, kVK_Return, true);
    CGEventRef spcu = CGEventCreateKeyboardEvent(src, kVK_Return, false);
    
    CGEventSetFlags(spcd, kCGEventFlagMaskCommand);
    CGEventSetFlags(spcu, kCGEventFlagMaskCommand);
    
    CGEventTapLocation loc = kCGHIDEventTap; // kCGSessionEventTap also works
    CGEventPost(loc, cmdd);
    CGEventPost(loc, spcd);
    CGEventPost(loc, spcu);
    CGEventPost(loc, cmdu);
    
    CFRelease(cmdd);
    CFRelease(cmdu);
    CFRelease(spcd);
    CFRelease(spcu);
    CFRelease(src);
}

+ (void)quit {
    CGEventSourceRef sourceRef = CGEventSourceCreate(kCGEventSourceStateHIDSystemState);
    CGEventRef tapDown= CGEventCreateKeyboardEvent(sourceRef, kVK_Escape, true);
    CGEventRef tapUp= CGEventCreateKeyboardEvent(sourceRef, kVK_Escape, false);
    CGEventTapLocation location = kCGHIDEventTap;
    CGEventPost(location, tapDown);
    CGEventPost(location, tapUp);
    CFRelease(tapDown);
    CFRelease(tapUp);
}

+ (void)next {
    CGEventSourceRef sourceRef = CGEventSourceCreate(kCGEventSourceStateHIDSystemState);
    CGEventRef arrowRightDown = CGEventCreateKeyboardEvent(sourceRef, kVK_RightArrow, true);
    CGEventRef arrowRightUp = CGEventCreateKeyboardEvent(sourceRef, kVK_RightArrow, false);
    CGEventTapLocation location = kCGHIDEventTap;
    CGEventPost(location, arrowRightDown);
    CGEventPost(location, arrowRightUp);
    CFRelease(arrowRightDown);
    CFRelease(arrowRightUp);
}

+ (void)previous {
    CGEventSourceRef sourceRef = CGEventSourceCreate(kCGEventSourceStateHIDSystemState);
    CGEventRef arrowLeftDown = CGEventCreateKeyboardEvent(sourceRef, kVK_LeftArrow, true);
    CGEventRef arrowLeftUp = CGEventCreateKeyboardEvent(sourceRef, kVK_LeftArrow, false);
    CGEventTapLocation location = kCGHIDEventTap;
    CGEventPost(location, arrowLeftDown);
    CGEventPost(location, arrowLeftUp);
    CFRelease(arrowLeftDown);
    CFRelease(arrowLeftUp);
}

+ (void)wakeMouse {
    CGEventSourceRef src = CGEventSourceCreate(kCGEventSourceStateHIDSystemState);
    
    CGEventRef cmdd = CGEventCreateKeyboardEvent(src, kVK_Command, true);
    CGEventRef cmdu = CGEventCreateKeyboardEvent(src, kVK_Command, false);
    CGEventRef spcd = CGEventCreateKeyboardEvent(src, kVK_ANSI_A, true);
    CGEventRef spcu = CGEventCreateKeyboardEvent(src, kVK_ANSI_A, false);
    
    CGEventSetFlags(spcd, kCGEventFlagMaskCommand);
    CGEventSetFlags(spcu, kCGEventFlagMaskCommand);
    
    CGEventTapLocation loc = kCGHIDEventTap; // kCGSessionEventTap also works
    CGEventPost(loc, cmdd);
    CGEventPost(loc, spcd);
    CGEventPost(loc, spcu);
    CGEventPost(loc, cmdu);
    
    CFRelease(cmdd);
    CFRelease(cmdu);
    CFRelease(spcd);
    CFRelease(spcu);
    CFRelease(src);
}

+ (void)warpMousePosition:(CGPoint)position {
    NSPoint p = [NSEvent mouseLocation];
    NSPoint newPoint = NSMakePoint(p.x+position.x, 800-p.y+position.y);
    CGWarpMouseCursorPosition(newPoint);
}

@end
