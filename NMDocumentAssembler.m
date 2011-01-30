#import "NMDocumentAssembler.h"
#import <ParseKit/ParseKit.h>
#import "NMDocument.h"
#import "NMParagraph.h"

@implementation NMDocumentAssembler

- (NMDocument *)currentFrom:(PKAssembly *)assembly {
	if (!assembly.target) {
		assembly.target = [NMDocument document];
	}
	
	return (NMDocument *)assembly.target;
}

- (void)didMatchWord:(PKAssembly *)assembly {
	NMDocument *doc = [self currentFrom:assembly];
	[[doc currentParagraph] addWord:[[assembly pop] stringValue]];
}

- (void)didMatchParaSeparator:(PKAssembly *)assembly {
	[[self currentFrom:assembly] startNewParagraph];
}

- (void)didMatchDocument:(PKAssembly *)assembly {
	[self currentFrom:assembly];
}

@end
