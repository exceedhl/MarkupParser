#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>
#import <Cedar/SpecHelper.h>
#import "NMParser.h"
#import "NMDocument.h"
#import "NMParagraph.h"

SPEC_BEGIN(ParseSpec)

describe(@"when parsing document", ^{
	describe(@"with a paragraph with normal texts", ^{
		it(@"should return a doc with only one paragraph", ^{
			NSString *text = @"this is a paragraph, and another sentence";
			
			NMParser *parser = [[[NMParser alloc] init] autorelease];
			NMDocument *doc = [parser parse:text];
			assertThat([NSNumber numberWithInt:[doc.items count]], is([NSNumber numberWithInt:1]));
			NMParagraph *paragraph = (NMParagraph *)[doc.items objectAtIndex:0];
			assertThat(paragraph.content, equalTo(text));
		});
	});
	
});



SPEC_END