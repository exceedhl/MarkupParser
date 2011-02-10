#import <Cocoa/Cocoa.h>


@interface NMText : NSObject<NSCopying> {
	NSMutableString *content;
}

+ (id)text;
- (void)addText:(NSString *)text;
	
@property(nonatomic, retain) NSMutableString *content;

@end
