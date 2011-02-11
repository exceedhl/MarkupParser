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

- (void)didMatchText:(PKAssembly *)assembly {
	NMDocument *doc = [self currentFrom:assembly];
	[doc addText:[[assembly pop] stringValue]];
}

- (void)didMatchLiteralText:(PKAssembly *)assembly {
	NMDocument *doc = [self currentFrom:assembly];
	[doc addText:[[[assembly pop] stringValue] stripPrefixBackslash]];
}

- (void)didMatchEmphasizedTag:(PKAssembly *)assembly {
	[[self currentFrom:assembly] startOrCloseEmphasizedText];
}

- (void)didMatchParaSeparator:(PKAssembly *)assembly {
	[[self currentFrom:assembly] startNewParagraph];
}

- (void)didMatchDocument:(PKAssembly *)assembly {
	[self currentFrom:assembly];
}

@end
