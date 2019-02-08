#include "testCallSwiftFromC.h"
#include "BazRef.h"

void testCallSwiftFromC()
{
    void *fobar = NLFooBarCreate(2);
    
    void *baz = NLBazCreate("Hello world!", 10);
    
    NLBazSetFooBar(baz, fobar);
    
    NLBazPrint(baz);
    NLBazRelease(baz);

    NLFooBarRelease(fobar);
}
