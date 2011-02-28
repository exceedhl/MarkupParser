#import "NMDocument.h"
#import "NMParagraph.h"

@interface NMDocument() {}
- (NMParagraph *)currentParagraph;
@end

@implementation NMDocument

+ (NMDocument *)document {
	return [[[NMDocument alloc] init] autorelease];
}

- (NMParagraph *)currentParagraph {
	if ([self.items count] == 0) {
		[self.items addObject:[NMParagraph paragraph]];
	}

	return [self.items lastObject];
}

- (void)addText:(NSString *)text {
	[[self currentParagraph] addText:text];
}

- (void)startNewParagraph {
	[self.items addObject:[NMParagraph paragraph]];
}

- (void)startOrCloseEmphasizedText {
	[[self currentParagraph] startOrCloseEmphasizedText];
}

@end
