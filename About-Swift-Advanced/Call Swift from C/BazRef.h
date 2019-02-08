
#ifndef BazRef_h
#define BazRef_h

#include <stdint.h>

// Baz
void* _Nonnull NLBazCreate(const char* _Nonnull aString, int32_t anInteger);
void NLBazRelease(void* _Nonnull bazRef);

void NLBazPrint(void* _Nonnull bazRef);
void NLBazSetFooBar(void* _Nonnull bazRef, void* _Nonnull foobarRef);

// FooBar
void* _Nonnull NLFooBarCreate(int32_t anInteger);
void NLFooBarRelease(void* _Nonnull foobarRef);
#endif
