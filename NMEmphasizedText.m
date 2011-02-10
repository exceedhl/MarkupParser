#import "NMEmphasizedText.h"
#import "NMText.h"

@interface NMEmphasizedText() {}

- (id)currentItem;

@end


@implementation NMEmphasizedText
@synthesize items;

- (id)init {
	if (self = [super init]) {
		self.items = [[NSMutableArray alloc] init];
	}
	return self;
}

+ (id)text {
	return [[[self alloc] init] autorelease];
}

- (void)addText:(NSString *)text {
	[[self currentItem] addText:text];
}

- (void)currentItem {
	if ([self.items count] == 0) {
		[self.items addObject:[NMText text]];
	}
	return [self.items lastObject];
}

- (id)copyWithZone:(NSZone *)zone {
	NMEmphasizedText *copy = NSAllocateObject([self class], 0, zone);
	copy.items = [self.items mutableCopyWithZone:zone];
	return copy;
}

- (void)dealloc {
	[self.items release];
	[super dealloc];
}

@end
