#import <Cocoa/Cocoa.h>


@interface NMParagraph : NSObject<NSCopying> {
	NSMutableString *content;
}

- (void)addWord:(NSString *)word;
+ (NMParagraph *)paragraph;

@property(nonatomic, retain) NSMutableString *content;

@end
