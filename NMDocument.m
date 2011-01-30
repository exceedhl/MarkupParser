#import "NMDocument.h"
#import "NMParagraph.h"

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

- (void)startNewParagraph {
	[self.items addObject:[NMParagraph paragraph]];
}

- (void)dealloc {
	[self.items release];
	[super dealloc];
}

@end
