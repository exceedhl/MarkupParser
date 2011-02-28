#import <Cocoa/Cocoa.h>
#import "NMContainer.h"

@interface NMEmphasizedText : NMContainer<NSCopying> {
}

+ (id)text;
- (void)addText:(NSString *)text;

@end
