#import "TestHelper.h"

SPEC_BEGIN(InlineMarkupSpec)

describe(@"parsing paragraph", ^{
	
	__block NMParser *parser;
	
	beforeEach(^{
		parser = [[[NMParser alloc] init] autorelease];
	});
	
	describe(@"with emphasized markup text", ^{
		it(@"should get paragraph with emphasized text object", ^{
			NSString *text = @"this is a *emphasized text* in a paragraph.";
			
			NMDocument *doc = [parser parse:text];
			NMParagraph *paragraph = (NMParagraph *)[doc.items objectAtIndex:0];
			assertEquals(3, [paragraph.items count]);
			assertThat(getFirstTextContent(paragraph), equalTo(@"this is a "));

			NMEmphasizedText *emphasizedText = (NMEmphasizedText *)[paragraph.items objectAtIndex:1];
			assertEquals(1, [emphasizedText.items count]);
			assertThat(getFirstTextContent(emphasizedText), equalTo(@"emphasized text"));
			
			assertThat(getTextContentAtIndex(paragraph, 2), equalTo(@" in a paragraph."));
		});
		
		it(@"should allow empty markup text", ^{
			
		});
		
		it(@"should allow newline in markup text", ^{
			
		});
		
		it(@"should treat unmatched tag as normal text", ^{
			
		});
		
		it(@"should ignore tag by preceding escape character", ^{
			
		});
		
		it(@"should allow escaped tag in markup text", ^{
			
		});
	});
	
});

SPEC_END