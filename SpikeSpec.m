#include "TestHelper.h"

SPEC_BEGIN(SpikeSpec)

describe(@"NSArray", ^{
	it(@"should return different hash for two different arrays", ^{
		NSMutableArray *array1 = [NSMutableArray array];
		[array1 addObject:[NSNumber numberWithInteger:1]];
		[array1 addObject:[NSNumber numberWithInteger:2]];
		NSMutableArray *array2 = [NSMutableArray array];
		[array1 addObject:[NSNumber numberWithInteger:1]];
		[array1 addObject:[NSNumber numberWithInteger:3]];
		
		NSLog(@"%d", [array1 hash]);
		NSLog(@"%d", [array2 hash]);		
		assertThat([NSNumber numberWithInteger:[array1 hash]], isNot(equalTo([NSNumber numberWithInteger:[array2 hash]])));
	});
});

SPEC_END