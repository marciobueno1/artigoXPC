//
//  XPCHelper.m
//  Cores
//
//  Created by Marcio Bueno on 18/12/22.
//

#import "XPCHelper.h"
#import "Cores-Swift.h"

@implementation XPCHelper

+ (NSColor *)getCorAleatoria:(CoresXPCUtility *)xpcUtility {
    __block NSColor *result;
    dispatch_semaphore_t xpcSemaphore = dispatch_semaphore_create(0);
    [[xpcUtility servicoXPC] getCorAleatoriaWithCompletionHandler:^(NSColor * _Nonnull corAleatoria) {
        result = corAleatoria;
        dispatch_semaphore_signal(xpcSemaphore);
    }];
    dispatch_semaphore_wait(xpcSemaphore, DISPATCH_TIME_FOREVER);
    return result;
}

@end
