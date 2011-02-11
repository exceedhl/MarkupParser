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
			NSString *text = @"**";
			
			NMDocument *doc = [parser parse:text];
			NMParagraph *paragraph = (NMParagraph *)[doc.items objectAtIndex:0];
			assertEquals(1, [paragraph.items count]);
			NMEmphasizedText *emphasizedText = (NMEmphasizedText *)[paragraph.items objectAtIndex:0];
			assertEquals(0, [emphasizedText.items count]);
		});
		
		it(@"should allow newline in markup text", ^{
			NSString *text = @"*emphasized\r text **in a \nparagraph.*";
			
			NMDocument *doc = [parser parse:text];
			NMParagraph *paragraph = (NMParagraph *)[doc.items objectAtIndex:0];
			assertEquals(2, [paragraph.items count]);
			
			NMEmphasizedText *emphasizedText = (NMEmphasizedText *)[paragraph.items objectAtIndex:0];
			assertEquals(1, [emphasizedText.items count]);
			assertThat(getFirstTextContent(emphasizedText), equalTo(@"emphasized\r text "));
			
			emphasizedText = (NMEmphasizedText *)[paragraph.items objectAtIndex:1];
			assertEquals(1, [emphasizedText.items count]);
			assertThat(getFirstTextContent(emphasizedText), equalTo(@"in a \nparagraph."));
		});
		
		it(@"should handle unmatched tag", ^{
			NSString *text = @"this is a *unmatched tag \r\n text";
			
			NMDocument *doc = [parser parse:text];
			NMParagraph *paragraph = (NMParagraph *)[doc.items objectAtIndex:0];
			assertEquals(2, [paragraph.items count]);
			
			NMEmphasizedText *emphasizedText = (NMEmphasizedText *)[paragraph.items objectAtIndex:1];
			assertEquals(1, [emphasizedText.items count]);
			assertThat(getFirstTextContent(emphasizedText), equalTo(@"unmatched tag \r\n text"));
			
		});
		
		it(@"should ignore tag by preceding escape character", ^{
			NSString *text = @"\\ \\\\\\**\\*\\\\*";
			
			NMDocument *doc = [parser parse:text];
			NMParagraph *paragraph = (NMParagraph *)[doc.items objectAtIndex:0];
			assertEquals(2, [paragraph.items count]);
			
			assertThat(getFirstTextContent(paragraph), equalTo(@"\\ \\*"));
			
			NMEmphasizedText *emphasizedText = (NMEmphasizedText *)[paragraph.items objectAtIndex:1];
			assertEquals(1, [emphasizedText.items count]);
			assertThat(getFirstTextContent(emphasizedText), equalTo(@"*\\"));
		});
	});
	
});

SPEC_END