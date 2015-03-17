//
//  main.m
//  MachPort
//
//  Created by FanFamily on 15/3/17.
//  Copyright (c) 2015年 FanFamily. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MachPortReceiver : NSObject<NSMachPortDelegate>



@end

@implementation MachPortReceiver

- (void)handleMachMessage:(void *)msg
{
    NSLog(@"Current NSThread %@", [NSThread currentThread]);
    NSLog(@"port 被激活了 ！");
}

@end

int main(int argc, const char * argv[]) {
    
    NSLog(@"begin");
    
    __block NSMachPort* port = [[NSMachPort alloc] init];
    
    MachPortReceiver* receiver = [[MachPortReceiver alloc] init];
    [port setDelegate:receiver];
    
    NSLog(@"Current NSThread %@", [NSThread currentThread]);
    
    [[NSRunLoop currentRunLoop] addPort:port
                                forMode:(NSString *)kCFRunLoopCommonModes];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [port sendBeforeDate:[NSDate date] components:nil from:nil reserved:0];
    });
    
    [[NSRunLoop currentRunLoop] run];
    return 0;
}
