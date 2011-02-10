#import "NMParser.h"
#import <ParseKit/ParseKit.h>
#import "NMDocumentAssembler.h"

#define TAB '\x09'
#define NEWLINE '\x0A'
#define RETURN '\x0D'

@interface NMParser() {}

- (PKTokenizer *)getTokenizer;
- (PKParser *)paraSeparatorParser:(NMDocumentAssembler *)assembler;
- (PKParser *)textParser:(NMDocumentAssembler *)assembler;
- (PKParser *)paragraphParser:(NMDocumentAssembler *)assembler;
- (PKParser *)documentParser:(NMDocumentAssembler *)assembler;
@end


@implementation NMParser

- (PKParser *)paraSeparatorParser:(NMDocumentAssembler *)assembler {
	PKSymbol *paraSeperator1 = [PKSymbol symbolWithString:@"\x0A\x0A"];
	PKSymbol *paraSeperator2 = [PKSymbol symbolWithString:@"\x0D\x0D"];
	PKSymbol *paraSeperator3 = [PKSymbol symbolWithString:@"\x0D\x0A\x0D\x0A"];
	PKAlternation *paraSeperator = [PKAlternation alternation];
	[paraSeperator add:paraSeperator1];
	[paraSeperator add:paraSeperator2];
	[paraSeperator add:paraSeperator3];
	
	[paraSeperator setAssembler:assembler selector:@selector(didMatchParaSeparator:)];
	return paraSeperator;
}

- (PKParser *)textParser:(NMDocumentAssembler *)assembler {
	PKSymbol *n = [PKSymbol symbolWithString:@"\x0A"];
	PKSymbol *r = [PKSymbol symbolWithString:@"\x0D"];
	
	PKAlternation *text = [PKAlternation alternation];
	[text add:[PKWord word]];
	[text add:n];
	[text add:r];
	
	[text setAssembler:assembler selector:@selector(didMatchText:)];
	return text;
}

- (PKParser *)paragraphParser:(NMDocumentAssembler *)assembler {
	return [PKRepetition repetitionWithSubparser:[self textParser:assembler]];
}

- (PKParser *)documentParser:(NMDocumentAssembler *)assembler {
	PKParser *paraParser = [self paragraphParser:assembler];

	PKSequence *morePara = [PKSequence sequence];
	[morePara add:[self paraSeparatorParser:assembler]];
	[morePara add:paraParser];
	
	PKSequence *doc = [PKSequence sequence];	
	[doc add:paraParser];
	[doc add:[PKRepetition repetitionWithSubparser:morePara]];	
	[doc setAssembler:assembler selector:@selector(didMatchDocument:)];
	return doc;
}

- (NMDocument *)parse:(NSString *)documentContent { 
	
	NMDocumentAssembler *assembler = [[[NMDocumentAssembler alloc] init] autorelease];	
	
	PKParser *doc = [self documentParser:assembler];
	[doc setTokenizer:[self getTokenizer]];
	
	NMDocument *document = (NMDocument *)[doc parse:documentContent];
	
	PKReleaseSubparserTree(doc);
	
	return document;
}

- (PKTokenizer *)getTokenizer {
	PKTokenizer *t = [PKTokenizer tokenizer];
	[t setTokenizerState:t.wordState from:32 to:255];
	[t setTokenizerState:t.wordState from:TAB to:TAB];
	[t.wordState setWordChars:YES from:32 to:255];
	[t.wordState setWordChars:YES from:TAB to:TAB];
	
	[t setTokenizerState:t.symbolState from:NEWLINE to:NEWLINE];
	[t setTokenizerState:t.symbolState from:RETURN to:RETURN];
	[t.symbolState add:[NSString stringWithFormat:@"%c%c", NEWLINE, NEWLINE]];
	[t.symbolState add:[NSString stringWithFormat:@"%c%c", RETURN, RETURN]];
	[t.symbolState add:[NSString stringWithFormat:@"%c%c%c%c", RETURN, NEWLINE, RETURN, NEWLINE]];
	return t;
}

@end
