#import <Cocoa/Cocoa.h>


@interface NMParagraph : NSObject<NSCopying> {
	NSMutableArray *items;
}

+ (NMParagraph *)paragraph;
- (void)addText:(NSString *)text;

@property(nonatomic, retain) NSMutableArray *items;

@end
