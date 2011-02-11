#import "PKTryTrack.h"

@implementation PKTryTrack

+ (id)track {
    return [super sequence];
}

- (NSSet *)allMatchesFor:(NSSet *)inAssemblies {
	NSParameterAssert(inAssemblies);
    BOOL inTrack = NO;
    NSSet *lastAssemblies = inAssemblies;
    NSSet *outAssemblies = inAssemblies;
    
    for (PKParser *p in subparsers) {
        outAssemblies = [p matchAndAssemble:outAssemblies];
        if (![outAssemblies count]) {
            if (inTrack) {
				return [NSSet setWithObject:[self best:lastAssemblies]];
            }
            break;
        }
        inTrack = YES;
        lastAssemblies = outAssemblies;
    }
    
    return outAssemblies;
}


@end
