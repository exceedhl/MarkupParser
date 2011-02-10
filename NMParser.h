#import <Cocoa/Cocoa.h>


@class NMDocument;

@interface NMParser : NSObject {
}

- (NMDocument *)parse:(NSString *)documentContent;

@end
