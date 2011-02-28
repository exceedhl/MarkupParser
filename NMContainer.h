#import <Cocoa/Cocoa.h>


@interface NMContainer : NSObject<NSCopying> {
	NSMutableArray *items;
}

@property(nonatomic, retain) NSMutableArray *items;

@end
