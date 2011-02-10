#import "NMText.h"


@implementation NMText

@synthesize content;

- (id)init {
	if (self = [super init]) {
		self.content = [[NSMutableString alloc] init];
	}
	return self;
}

+ (id)text {
	return [[[self alloc] init] autorelease];
}

- (void)addText:(NSString *)text {
	[self.content appendString:text];
}

- (id)copyWithZone:(NSZone *)zone {
	NMText *copy = NSAllocateObject([self class], 0, zone);
	copy.content = [self.content mutableCopyWithZone:zone];
	return copy;
}

- (void)dealloc {
	[self.content release];
	[super dealloc];
}


@end
