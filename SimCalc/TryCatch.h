//
//  TryCatch.h
//  SimCalc
//
//  Created by 위대연 on 2021/06/09.
//

#import "SimCalc-Bridging-Header.h"

@interface TryCatch : NSObject 
+ (BOOL)tryBlock:(void(^)(void))tryBlock
           error:(NSError **)error;
@end

