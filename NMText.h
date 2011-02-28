#import <Cocoa/Cocoa.h>


@interface NMText : NSObject<NSCopying> {
	NSMutableString *content;
}

+ (id)text;
+ (id)textWithString:(NSString *)string;
- (void)addText:(NSString *)text;
	
@property(nonatomic, retain) NSMutableString *content;

@end
