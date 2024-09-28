#ifndef ImportSwiftAsFunctions_h
#define ImportSwiftAsFunctions_h

#include <CoreFoundation/CoreFoundation.h>
#include <stdint.h>

CF_ASSUME_NONNULL_BEGIN

typedef struct Owner* OwnerRef;
typedef struct Value* ValueRef;

#pragma mark - Owner

OwnerRef OwnerCreate(char const * string, int32_t integer);
void OwnerRelease(OwnerRef instanceRef);
void OwnerDump(OwnerRef instanceRef);
void OwnerSetValue(OwnerRef instanceRef, ValueRef valueRef);

#pragma mark - Value

ValueRef ValueCreate(int32_t integer);
void ValueRelease(ValueRef instanceRef);

CF_ASSUME_NONNULL_END

#endif
