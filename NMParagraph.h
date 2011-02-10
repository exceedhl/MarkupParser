#import <Cocoa/Cocoa.h>


@interface NMParagraph : NSObject<NSCopying> {
	NSMutableArray *items;
	id currentItem;
}

+ (NMParagraph *)paragraph;
- (void)addText:(NSString *)text;
- (void)startOrCloseEmphasizedText;

@property(nonatomic, retain) NSMutableArray *items;

@end
