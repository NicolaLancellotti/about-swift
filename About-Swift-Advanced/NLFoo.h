#ifndef NLFoo_h
#define NLFoo_h

#include <CoreFoundation/CoreFoundation.h>

CF_ASSUME_NONNULL_BEGIN

typedef struct NLFoo *NLFooRef;

NLFooRef NLFooCreate(int value);

int NLFooGetValue(const NLFooRef foo);

void NLFooSetValue(NLFooRef foo, int value);

void NLFooRelease(NLFooRef foo);

#endif

CF_ASSUME_NONNULL_END
