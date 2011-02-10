#import "NMDocument.h"
#import "NMParagraph.h"

@interface NMDocument() {}
- (NMParagraph *)currentParagraph;
@end

@implementation NMDocument
@synthesize items;

- (id)init {
	if (self = [super init]) {
		self.items = [[NSMutableArray alloc] init];
	}
	return self;
}

- (id)copyWithZone:(NSZone *)zone {
	NMDocument *copy = NSAllocateObject([self class], 0, zone);
	copy.items = [self.items mutableCopyWithZone:zone];
	return copy;
}

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

- (void)dealloc {
	[self.items release];
	[super dealloc];
}

@end
