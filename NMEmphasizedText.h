#import <Cocoa/Cocoa.h>


@interface NMEmphasizedText : NSObject<NSCopying> {
	NSMutableArray *items;
}

+ (id)text;
- (void)addText:(NSString *)text;

@property(nonatomic, retain) NSMutableArray *items;

@end
