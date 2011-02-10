#import "NMParagraph.h"
#import "NMText.h"

@interface NMParagraph() {}

- (id)currentItem;

@end


@implementation NMParagraph

@synthesize items;

- (id)init {
	if (self = [super init]) {
		self.items = [[NSMutableArray alloc] init];
	}
	return self;
}

- (id)copyWithZone:(NSZone *)zone {
	NMParagraph *copy = NSAllocateObject([self class], 0, zone);
	copy.items = [self.items mutableCopyWithZone:zone];
	return copy;
}

+ (NMParagraph *)paragraph {
	return [[[NMParagraph alloc] init] autorelease];
}

- (void)addText:(NSString *)text {
	[[self currentItem] addText:text];
}

- (id)currentItem {
	if ([self.items count] == 0) {
		[self.items addObject:[NMText text]];
	}
	return [self.items lastObject];
}

- (void)dealloc {
	[self.items release];
	[super dealloc];
}

@end
