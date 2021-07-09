#include "testCallSwiftFromC.h"
#include "BazRef.h"
#include "BazRef2.h"
#include <stdio.h>

void testCallSwiftFromC()
{
  {
    // First Way
    printf("\nFirstWay\n");
    
    void *foobar = NLFooBarCreate(2);
    void *baz = NLBazCreate("Hello world!", 10);
    NLBazSetFooBar(baz, foobar);
    NLBazPrint(baz);
    NLBazRelease(baz);
    NLFooBarRelease(foobar);
  }
  
  {
    // Second Way
    printf("\nSecond Way\n");
    const Lib* lib = getLib();
    
    void *foobar = lib->fooBar.create(2);
    void *baz = lib->baz.create("Hello world!", 10);
    lib->baz.setFooBar(baz, foobar);
    lib->baz.print(baz);
    lib->baz.release(baz);
    lib->fooBar.release(foobar);
  }
  
}
