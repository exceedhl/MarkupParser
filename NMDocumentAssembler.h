#import <Cocoa/Cocoa.h>

@class NMDocument;
@class PKAssembly;

@interface NMDocumentAssembler : NSObject {
}

- (void)didMatchText:(PKAssembly *)assembly;
- (void)didMatchParaSeparator:(PKAssembly *)assembly;
- (void)didMatchDocument:(PKAssembly *)assembly;
- (void)didMatchEmphasizedTag:(PKAssembly *)assembly;

- (NMDocument *)currentFrom:(PKAssembly *)assembly;

@end
