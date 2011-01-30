#import "NMParagraph.h"


@implementation NMParagraph

@synthesize content;

- (id)init {
	if (self = [super init]) {
		self.content = [[NSMutableString alloc] init];
	}
	return self;
}

- (id)copyWithZone:(NSZone *)zone {
	NMParagraph *copy = NSAllocateObject([self class], 0, zone);
	copy.content = [self.content mutableCopyWithZone:zone];
	return copy;
}

+ (NMParagraph *)paragraph {
	return [[[NMParagraph alloc] init] autorelease];
}

- (void)addWord:(NSString *)word {
	[self.content appendString:word];
}

- (void)dealloc {
	[self.content release];
	[super dealloc];
}

@end
