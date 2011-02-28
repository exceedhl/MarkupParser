#include "TestHelper.h"
#include "NMText.h"

SPEC_BEGIN(NMTextSpec)

describe(@"NMText", ^{
	it(@"should equal to text with same content", ^{
		NMText *t1 = [NMText text];
		[t1.content appendString:@"one"];
		NMText *t2 = [NMText text];
		[t2.content appendString:@"one"];
		NMText *t3 = [NMText text];
		[t3.content appendString:@"two"];
		assertThat(t1, is(t2));
		assertThat(t1, isNot(t3));
		assertEquals([t1 hash], [t2 hash]);
		assertNotEquals([t1 hash], [t3 hash]);
	});
});

SPEC_END