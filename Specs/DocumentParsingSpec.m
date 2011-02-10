#import "TestHelper.h"

SPEC_BEGIN(DocumentParsingSpec)

describe(@"parsing document", ^{
	
	__block NMParser *parser;
	
	beforeEach(^{
		parser = [[[NMParser alloc] init] autorelease];
	});
	
	//describe(@"with empty content", ^{
//		it(@"should return a empty document", ^{
//			NSString *text = @"";
//			
//			NMDocument *doc = [parser parse:text];
//			assertEquals(0, [doc.items count]);
//		});
//	});
//	
//	describe(@"with whitespaces", ^{
//		it(@"should return a valid document", ^{
//			NSString *text = @"\n  \t  \t \r\n\r\n   \r\n";
//			
//			NMDocument *doc = [parser parse:text];
//			assertEquals(2, [doc.items count]);
//			NMParagraph *paragraph = (NMParagraph *)[doc.items objectAtIndex:0];
//			assertThat(getFirstTextContent(paragraph), equalTo(@"\n  \t  \t "));
//			paragraph = (NMParagraph *)[doc.items objectAtIndex:1];
//			assertThat(getFirstTextContent(paragraph), equalTo(@"   \r\n"));
//		});
//	});
//	
//	describe(@"with only one paragraph", ^{
//		it(@"should return a doc with only one paragraph", ^{
//			NSString *text = @"this is a paragraph, and another sentence";
//			
//			NMDocument *doc = [parser parse:text];
//			assertEquals(1, [doc.items count]);
//			NMParagraph *paragraph = (NMParagraph *)[doc.items objectAtIndex:0];
//			assertThat(getFirstTextContent(paragraph), equalTo(text));
//		});
//	});
	
});

SPEC_END