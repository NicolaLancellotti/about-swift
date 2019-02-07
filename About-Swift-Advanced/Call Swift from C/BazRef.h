
#ifndef BazRef_h
#define BazRef_h

#include <stdint.h>

void* _Nonnull NLBazCreate(const char* _Nonnull aString, int32_t anInteger);
void NLBazPrint(void* _Nonnull);
void NLBazRelease(void* _Nonnull);

#endif
