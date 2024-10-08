#include <stdio.h>
#include "UseImportSwift.h"
#include "ImportSwiftAsFunctions.h"
#include "ImportSwiftAsPointers.h"

void useImportSwift(void)
{
  {
    // Import Swift As Functions
    void *value = ValueCreate(2);
    void *owner = OwnerCreate("Hello world!", 10);
    OwnerSetValue(owner, value);
    OwnerDump(owner);
    OwnerRelease(owner);
    ValueRelease(value);
  }
  
  {
    // Import Swift As Pointers
    Lib const *lib = getLib();
    void *value = lib->value.create(2);
    void *owner = lib->owner.create("Hello world!", 10);
    lib->owner.setValue(owner, value);
    lib->owner.dump(owner);
    lib->owner.release(owner);
    lib->value.release(value);
  }
  
}
