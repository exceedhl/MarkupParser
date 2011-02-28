#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>
#import <Cedar/SpecHelper.h>
#import "NMParser.h"
#import "NMDocument.h"
#import "NMParagraph.h"
#import "NMText.h"
#import "NMEmphasizedText.h"

#define assertEquals(expected, actual) \
assertThat([NSNumber numberWithInt:actual], is([NSNumber numberWithInt:expected]))

#define assertNotEquals(expected, actual) \
assertThat([NSNumber numberWithInt:actual], isNot([NSNumber numberWithInt:expected]))

#define getTextContentAtIndex(object, index) \
(((NMText *)[object.items objectAtIndex:index]).content)

#define getFirstTextContent(object) \
(((NMText *)[object.items objectAtIndex:0]).content)