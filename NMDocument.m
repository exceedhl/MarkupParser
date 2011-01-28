#import "NMDocument.h"


@implementation NMDocument

@synthesize items;

- (id)init {
	if (self = [super init]) {
		self.items = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)dealloc {
	[self.items release];
	[super dealloc];
}

@end
