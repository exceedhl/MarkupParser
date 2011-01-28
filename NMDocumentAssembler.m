#import "NMDocumentAssembler.h"
#import <ParseKit/ParseKit.h>
#import "NMDocument.h"
#import "NMParagraph.h"

@implementation NMDocumentAssembler

@synthesize document;

- (id)init {
	if (self = [super init]) {
		self.document = [[NMDocument alloc] init];
	}
	return self;
}

- (void)didMatchParagraph:(PKAssembly *)assembly {
	NSMutableArray *contents = [[NSMutableArray alloc] init];
	while (![assembly isStackEmpty]) {
		[contents insertObject:[assembly pop] atIndex:0]; 
	}
	NMParagraph *paragraph = [[NMParagraph alloc] init];
	paragraph.content = [contents componentsJoinedByString:@""];
	[self.document.items addObject:paragraph];
	[contents release];
}

- (void)dealloc {
	[self.document release];
	[super dealloc];
}
@end
