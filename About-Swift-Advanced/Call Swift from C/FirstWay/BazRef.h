#ifndef BazRef_h
#define BazRef_h

#include <stdint.h>

typedef struct CBazType* CBazRef;
typedef struct CFooBarType* CFooBarRef;

// Baz
CBazRef _Nonnull NLBazCreate(const char* _Nonnull aString, int32_t anInteger);
void NLBazRelease(CBazRef _Nonnull bazRef);
void NLBazPrint(CBazRef _Nonnull bazRef);
void NLBazSetFooBar(CBazRef _Nonnull bazRef, CFooBarRef _Nonnull foobarRef);

// FooBar
CFooBarRef _Nonnull NLFooBarCreate(int32_t anInteger);
void NLFooBarRelease(CFooBarRef _Nonnull foobarRef);

#endif
