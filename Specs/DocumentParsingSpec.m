#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>
#import <Cedar/SpecHelper.h>
#import "NMParser.h"
#import "NMDocument.h"
#import "NMParagraph.h"

#define assertEquals(expected, actual) \
	assertThat([NSNumber numberWithInt:actual], is([NSNumber numberWithInt:expected]))

SPEC_BEGIN(DocumentParsingSpec)

describe(@"when parsing document", ^{
	describe(@"with empty content", ^{
		it(@"should return a empty document", ^{
			NSString *text = @"";
			
			NMParser *parser = [[[NMParser alloc] init] autorelease];
			NMDocument *doc = [parser parse:text];
			assertEquals(0, [doc.items count]);
		});
	});
	
	describe(@"with whitespaces", ^{
		it(@"should return a valid document", ^{
			NSString *text = @"\n  \t  \t \r\n\r\n   \r\n";
			
			NMParser *parser = [[[NMParser alloc] init] autorelease];
			NMDocument *doc = [parser parse:text];
			assertEquals(2, [doc.items count]);
			NMParagraph *paragraph = (NMParagraph *)[doc.items objectAtIndex:0];
			assertThat(paragraph.content, equalTo(@"\n  \t  \t "));
			paragraph = (NMParagraph *)[doc.items objectAtIndex:1];
			assertThat(paragraph.content, equalTo(@"   \r\n"));
		});
	});
	
	describe(@"with only one paragraph", ^{
		it(@"should return a doc with only one paragraph", ^{
			NSString *text = @"this is a paragraph, and another sentence";
			
			NMParser *parser = [[[NMParser alloc] init] autorelease];
			NMDocument *doc = [parser parse:text];
			assertEquals(1, [doc.items count]);
			NMParagraph *paragraph = (NMParagraph *)[doc.items objectAtIndex:0];
			assertThat(paragraph.content, equalTo(text));
		});
	});
	
});



SPEC_END