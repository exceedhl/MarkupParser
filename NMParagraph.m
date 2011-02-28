#import "NMParagraph.h"
#import "NMText.h"
#import "NMEmphasizedText.h"

@interface NMParagraph() {}

- (id)currentItem;

@end


@implementation NMParagraph

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
	if ([currentItem isKindOfClass:[NMEmphasizedText class]]) {
		currentItem = nil;
		return;
	}
	[self.items addObject:[NMEmphasizedText text]];
	currentItem = [self.items lastObject];
}
@end
