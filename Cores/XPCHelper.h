//
//  XPCHelper.h
//  Cores
//
//  Created by Marcio Bueno on 18/12/22.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CoresXPCUtility;

@interface XPCHelper : NSObject
+ (NSColor *)getCorAleatoria:(CoresXPCUtility *)xpcUtility;
@end

NS_ASSUME_NONNULL_END
