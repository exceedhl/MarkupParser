#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>
#import <Cedar/SpecHelper.h>
#import "NMParser.h"
#import "NMDocument.h"
#import "NMParagraph.h"

#define assertEquals(expected, actual) \
assertThat([NSNumber numberWithInt:actual], is([NSNumber numberWithInt:expected]))