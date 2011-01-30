#import <Cocoa/Cocoa.h>

@class NMDocument;
@class PKAssembly;

@interface NMDocumentAssembler : NSObject {
}

- (void)didMatchWord:(PKAssembly *)assembly;
- (void)didMatchParaSeparator:(PKAssembly *)assembly;
- (void)didMatchDocument:(PKAssembly *)assembly;
- (NMDocument *)currentFrom:(PKAssembly *)assembly;

@end
