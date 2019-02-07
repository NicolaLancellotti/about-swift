#include "testCallSwiftFromC.h"
#include "BazRef.h"

void testCallSwiftFromC()
{
    void *baz = NLBazCreate("Hello world!", 10);
    NLBazPrint(baz);
    NLBazRelease(baz);
}
