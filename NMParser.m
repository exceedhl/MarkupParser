#import "NMParser.h"
#import <ParseKit/ParseKit.h>
#import "NMDocumentAssembler.h"

@interface NMParser() {}

- (PKTokenizer *)getTokenizer;

@end


@implementation NMParser
- (NMDocument *)parse:(NSString *)documentContent { 
	
	PKSymbol *paraSeperator1 = [PKSymbol symbolWithString:@"\x0A\x0A"];
	PKSymbol *paraSeperator2 = [PKSymbol symbolWithString:@"\x0D\x0D"];
	PKSymbol *paraSeperator3 = [PKSymbol symbolWithString:@"\x0D\x0A\x0D\x0A"];
	PKAlternation *paraSeperator = [PKAlternation alternation];
	[paraSeperator add:paraSeperator1];
	[paraSeperator add:paraSeperator2];
	[paraSeperator add:paraSeperator3];
	
	PKSymbol *n = [PKSymbol symbolWithString:@"\x0A"];
	PKSymbol *r = [PKSymbol symbolWithString:@"\x0D"];
	
	PKAlternation *text = [PKAlternation alternation];
	[text add:[PKWord word]];
	[text add:n];
	[text add:r];
	
	PKRepetition *para = [PKRepetition repetitionWithSubparser:text];
	
	PKSequence *doc = [PKSequence sequence];
	[doc add:para];
	PKSequence *morePara = [PKSequence sequence];
	[morePara add:paraSeperator];
	[morePara add:para];
	
	[doc add:[PKRepetition repetitionWithSubparser:morePara]];
	
	[doc setTokenizer:[self getTokenizer]];
	
	NMDocumentAssembler *assembler = [[[NMDocumentAssembler alloc] init] autorelease];
	[text setAssembler:assembler selector:@selector(didMatchText:)];
	[paraSeperator setAssembler:assembler selector:@selector(didMatchParaSeparator:)];
	[doc setAssembler:assembler selector:@selector(didMatchDocument:)];
	
	NMDocument *document = (NMDocument *)[doc parse:documentContent];
	
	PKReleaseSubparserTree(doc);
	
	return document;
}

- (PKTokenizer *)getTokenizer {
	PKTokenizer *t = [PKTokenizer tokenizer];
	[t setTokenizerState:t.wordState from:32 to:255];
	[t setTokenizerState:t.wordState from:'\x09' to:'\x09'];
	[t.wordState setWordChars:YES from:32 to:255];
	[t.wordState setWordChars:YES from:'\x09' to:'\x09'];
	
	[t setTokenizerState:t.symbolState from:'\x0A' to:'\x0A'];
	[t setTokenizerState:t.symbolState from:'\x0D' to:'\x0D'];
	[t.symbolState add:@"\x0A\x0A"];
	[t.symbolState add:@"\x0D\x0D"];
	[t.symbolState add:@"\x0D\x0A\x0D\x0A"];
	return t;
}

@end
