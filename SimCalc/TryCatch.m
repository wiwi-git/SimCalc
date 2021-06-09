//
//  TryCatch.m
//  SimCalc
//
//  Created by 위대연 on 2021/06/09.
//

#import "SimCalc-Bridging-Header.h"

@implementation TryCatch

+ (BOOL)tryBlock:(void(^)(void))tryBlock
           error:(NSError **)error
{
    @try {
        tryBlock ? tryBlock() : nil;
    }
    @catch (NSException *exception) {
        if (error) {
            *error = [NSError errorWithDomain:@"com.dy.SimCalc"
                                         code:42
                                     userInfo:@{NSLocalizedDescriptionKey: exception.name}];
        }
        return NO;
    }
    return YES;
}
@end
