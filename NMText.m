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

+ (id)textWithString:(NSString *)string {
	NMText *text = [[self alloc] init];
	[text.content appendString:string];
	return [text autorelease];
}

- (void)addText:(NSString *)text {
	[self.content appendString:text];
}

- (id)copyWithZone:(NSZone *)zone {
	NMText *copy = NSAllocateObject([self class], 0, zone);
	copy.content = [self.content mutableCopyWithZone:zone];
	return copy;
}

- (BOOL)isEqual:(id)other {
	if (other == self)
        return YES;
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    if (![self.content isEqual:((NMText *)other).content])
        return NO;
    return YES;
}

- (NSUInteger)hash
{
	return [self.content hash];
}

- (void)dealloc {
	[self.content release];
	[super dealloc];
}


@end
