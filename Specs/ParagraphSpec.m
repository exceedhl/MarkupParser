#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>
#import <Cedar/SpecHelper.h>

SPEC_BEGIN(ParagraphSpec)

describe(@"Foo", ^{
	
    it(@"should do something", ^{
		assertThat(@"hello", equalTo(@"hello2"));
    });
	
});


SPEC_END