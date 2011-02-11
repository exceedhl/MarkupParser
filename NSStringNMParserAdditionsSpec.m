#import "TestHelper.h"
#import "NSString+NMParserAdditions.h"

SPEC_BEGIN(NSStringNMParserAdditions)

describe(@"NSString", ^{
	it(@"should return string without prefix backslash", ^{
		NSString *s = @"\\*";
		assertThat([s stripPrefixBackslash], equalTo(@"*"));
	});
});

SPEC_END