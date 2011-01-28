#import <Cocoa/Cocoa.h>


@interface NMDocument : NSObject {
	NSMutableArray *items;
}

@property(nonatomic, retain) NSMutableArray *items;

@end
