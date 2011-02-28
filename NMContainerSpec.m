#include "TestHelper.h"
#include "NMContainer.h"

SPEC_BEGIN(NMContainerSpec)

describe(@"NMContainer", ^{
	it(@"should be equal to container with same contents", ^{
		NMContainer *doc1 = [[NMContainer alloc] init];
		[doc1.items addObject:@"one"];
		NMContainer *doc2 = [[NMContainer alloc] init];
		[doc2.items addObject:@"one"];
		NMContainer *doc3 = [[NMContainer alloc] init];
		[doc3.items addObject:@"two"];
		assertThat(doc1, is(doc2));
		assertThat(doc1, isNot(doc3));
		[doc1 release];
		[doc2 release];
		[doc3 release];
	});
});

SPEC_END