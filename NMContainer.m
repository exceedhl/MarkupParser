#import "NMContainer.h"


@implementation NMContainer

@synthesize items;

- (id)init {
	if (self = [super init]) {
		self.items = [[NSMutableArray alloc] init];
	}
	return self;
}

- (id)copyWithZone:(NSZone *)zone {
	NMContainer *copy = NSAllocateObject([self class], 0, zone);
	copy.items = [self.items mutableCopyWithZone:zone];
	return copy;
}

- (BOOL)isEqual:(id)other {
	if (other == self)
        return YES;
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    if (![self.items isEqual:((NMContainer *)other).items])
        return NO;
    return YES;
}

- (NSUInteger)hash
{
	return [self.items hash];
}

- (void)dealloc {
	[self.items release];
	[super dealloc];
}
@end
