#import <Cocoa/Cocoa.h>

@class NMParagraph;

@interface NMDocument : NSObject<NSCopying> {
	NSMutableArray *items;
}

+ (NMDocument *)document;
- (void)startNewParagraph;
- (void)addText:(NSString *)text;

@property(nonatomic, retain) NSMutableArray *items;

@end
