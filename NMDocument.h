#import <Cocoa/Cocoa.h>

@class NMParagraph;

@interface NMDocument : NSObject<NSCopying> {
	NSMutableArray *items;
}

+ (NMDocument *)document;
- (NMParagraph *)currentParagraph;
- (void)startNewParagraph;

@property(nonatomic, retain) NSMutableArray *items;

@end
