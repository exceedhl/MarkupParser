#import "NMParser.h"
#import <ParseKit/ParseKit.h>
#import "NMDocumentAssembler.h"
#import "PKTryTrack.h"

#define TAB '\x09'
#define NEWLINE '\x0A'
#define RETURN '\x0D'

#define DOUBLE_NEWLINE ([NSString stringWithFormat:@"%c%c", NEWLINE, NEWLINE])
#define DOUBLE_RETURN ([NSString stringWithFormat:@"%c%c", RETURN, RETURN])
#define DOUBLE_RETURN_NEWLINE ([NSString stringWithFormat:@"%c%c%c%c", RETURN, NEWLINE, RETURN, NEWLINE])

#define EM_TAG '*'

@interface NMParser() {}

- (PKTokenizer *)getTokenizer;
- (PKParser *)paraSeparatorParser:(NMDocumentAssembler *)assembler;
- (PKParser *)textParser:(NMDocumentAssembler *)assembler;
- (PKParser *)paragraphParser:(NMDocumentAssembler *)assembler;
- (PKParser *)documentParser:(NMDocumentAssembler *)assembler;
@end


@implementation NMParser

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
	[t.wordState setWordChars:NO from:EM_TAG to:EM_TAG];
	
	[t setTokenizerState:t.symbolState from:NEWLINE to:NEWLINE];
	[t setTokenizerState:t.symbolState from:RETURN to:RETURN];
	[t setTokenizerState:t.symbolState from:EM_TAG to:EM_TAG];
	[t.symbolState add:DOUBLE_NEWLINE];
	[t.symbolState add:DOUBLE_RETURN];
	[t.symbolState add:DOUBLE_RETURN_NEWLINE];
	return t;
}

- (PKParser *)paraSeparatorParser:(NMDocumentAssembler *)assembler {
	PKSymbol *paraSeperator1 = [PKSymbol symbolWithString:DOUBLE_RETURN];
	PKSymbol *paraSeperator2 = [PKSymbol symbolWithString:DOUBLE_NEWLINE];
	PKSymbol *paraSeperator3 = [PKSymbol symbolWithString:DOUBLE_RETURN_NEWLINE];
	PKAlternation *paraSeperator = [PKAlternation alternation];
	[paraSeperator add:paraSeperator1];
	[paraSeperator add:paraSeperator2];
	[paraSeperator add:paraSeperator3];
	
	[paraSeperator setAssembler:assembler selector:@selector(didMatchParaSeparator:)];
	return paraSeperator;
}

- (PKParser *)textParser:(NMDocumentAssembler *)assembler {
	PKSymbol *n = [PKSymbol symbolWithString:[NSString stringWithFormat:@"%c", RETURN]];
	PKSymbol *r = [PKSymbol symbolWithString:[NSString stringWithFormat:@"%c", NEWLINE]];
	
	PKAlternation *text = [PKAlternation alternation];
	[text add:[PKWord word]];
	[text add:n];
	[text add:r];
	
	[text setAssembler:assembler selector:@selector(didMatchText:)];
	return text;
}

- (PKParser *)emTextParser:(NMDocumentAssembler *)assembler {
	PKSymbol *emTag = [PKSymbol symbolWithString:[NSString stringWithFormat:@"%c", EM_TAG]];
	[emTag discard];
	PKTryTrack *emText = [PKTryTrack track];
	[emText add:emTag];
	[emText add:[PKRepetition repetitionWithSubparser:[self textParser:assembler]]];
	[emText add:emTag];
	
	[emTag setAssembler:assembler selector:@selector(didMatchEmphasizedTag:)];
	return emText;
}

- (PKParser *)paragraphParser:(NMDocumentAssembler *)assembler {
	PKAlternation *paraElement = [PKAlternation alternation];
	[paraElement add:[self textParser:assembler]];
	[paraElement add:[self emTextParser:assembler]];
	
	return [PKRepetition repetitionWithSubparser:paraElement];
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

@end
