#import <Cocoa/Cocoa.h>
#import "NMContainer.h"

@interface NMParagraph : NMContainer<NSCopying> {
	id currentItem;
}

+ (NMParagraph *)paragraph;
- (void)addText:(NSString *)text;
- (void)startOrCloseEmphasizedText;

@end
