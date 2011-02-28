#import "NMEmphasizedText.h"
#import "NMText.h"

@interface NMEmphasizedText() {}

- (id)currentItem;

@end

@implementation NMEmphasizedText
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

@end
