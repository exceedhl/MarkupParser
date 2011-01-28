#import "NMParser.h"
#import <ParseKit/ParseKit.h>
#import "NMDocumentAssembler.h"

@interface NMParser() {}

- (PKTokenizer *)getTokenizer;

@end


@implementation NMParser
- (NMDocument *)parse:(NSString *)text { 
	
	PKWord *word = [PKWord word];
	PKRepetition *parser = [[PKRepetition alloc] initWithSubparser:word];
	[parser setTokenizer:[self getTokenizer]];
	

	NMDocumentAssembler *assembler = [[[NMDocumentAssembler alloc] init] autorelease];
	[word setAssembler:assembler selector:@selector(didMatchParagraph:)];
	[parser parse:text];
	
	PKReleaseSubparserTree(parser);

	return assembler.document;
}

- (PKTokenizer *)getTokenizer {
	PKTokenizer *t = [PKTokenizer tokenizer];
	[t setTokenizerState:t.wordState from:32 to:255];
	[t.wordState setWordChars:YES from:32 to:255];
	
	return t;
}

@end
