#include "testCallSwiftFromC.h"
#include "BazRef.h"
#include "BazRef2.h"
#include <stdio.h>

void testCallSwiftFromC()
{
    {
        // First Way
        printf("\nFirstWay\n");
        
        void *fobar = NLFooBarCreate(2);
        void *baz = NLBazCreate("Hello world!", 10);
        NLBazSetFooBar(baz, fobar);
        NLBazPrint(baz);
        NLBazRelease(baz);
        NLFooBarRelease(fobar);
    }
    
    {
        // Second Way
        printf("\nSecond Way\n");
        const Lib* lib = getLib();
        
        void *fobar = lib->fooBar.create(2);
        void *baz = lib->baz.create("Hello world!", 10);
        lib->baz.setFooBar(baz, fobar);
        lib->baz.print(baz);
        lib->baz.release(baz);
        lib->fooBar.release(fobar);
    }
    
}
