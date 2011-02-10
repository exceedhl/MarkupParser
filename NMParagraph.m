#import "NMParagraph.h"
#import "NMText.h"
#import "NMEmphasizedText.h"

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
	if (currentItem == nil) {
		[self.items addObject:[NMText text]];
	}
	return currentItem = [self.items lastObject];
}

- (void)startOrCloseEmphasizedText {
	if ([[self currentItem] isKindOfClass:[NMEmphasizedText class]]) {
		currentItem = nil;
		return;
	}
	[self.items addObject:[NMEmphasizedText text]];
	currentItem = [self.items lastObject];
}

- (void)dealloc {
	[self.items release];
	[super dealloc];
}

@end
