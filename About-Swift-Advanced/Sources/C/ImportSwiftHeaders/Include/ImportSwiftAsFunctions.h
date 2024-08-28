#ifndef OwnerRef_h
#define OwnerRef_h

#include <stdint.h>

typedef struct Owner* OwnerRef;
typedef struct Value* ValueRef;

#pragma mark - Owner

OwnerRef _Nonnull OwnerCreate(const char* _Nonnull string, int32_t integer);
void OwnerRelease(OwnerRef _Nonnull instanceRef);
void OwnerDump(OwnerRef _Nonnull instanceRef);
void OwnerSetValue(OwnerRef _Nonnull instanceRef, ValueRef _Nonnull valueRef);

#pragma mark - Value

ValueRef _Nonnull ValueCreate(int32_t integer);
void ValueRelease(ValueRef _Nonnull instanceRef);

#endif
