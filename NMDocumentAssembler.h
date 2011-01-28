#import <Cocoa/Cocoa.h>

@class NMDocument;
@class PKAssembly;

@interface NMDocumentAssembler : NSObject {
	NMDocument *document;
}

- (void)didMatchParagraph:(PKAssembly *)assembly;

@property(nonatomic, retain) NMDocument *document;
@end
