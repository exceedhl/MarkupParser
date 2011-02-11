#import "NSString+NMParserAdditions.h"


@implementation NSString(ParseKitAdditions)
- (NSString *)stripPrefixBackslash {
	return [self substringFromIndex:1];
}
@end
