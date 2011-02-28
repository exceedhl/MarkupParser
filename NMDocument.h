#import <Cocoa/Cocoa.h>
#import "NMContainer.h"

@interface NMDocument : NMContainer<NSCopying> {
}

+ (NMDocument *)document;
- (void)startNewParagraph;
- (void)startOrCloseEmphasizedText;
- (void)addText:(NSString *)text;

@end
