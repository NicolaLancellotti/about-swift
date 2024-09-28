#ifndef ImportSwiftAsPointers_h
#define ImportSwiftAsPointers_h

#include <CoreFoundation/CoreFoundation.h>
#include <stdint.h>

CF_ASSUME_NONNULL_BEGIN

typedef struct Owner* OwnerRef;
typedef struct Value* ValueRef;

#pragma mark - Owner

typedef struct {
  OwnerRef _Nonnull (* _Nonnull create) (char const *string, int32_t integer);
  void (*release) (OwnerRef instanceRef);
  void (*dump) (OwnerRef instanceRef);
  void (*setValue) (OwnerRef instanceRef, ValueRef valueRef);
} COwner;

#pragma mark - Value

typedef struct {
  ValueRef _Nonnull (* _Nonnull create) (int32_t value);
  void (*release) (ValueRef instanceRef);
} CValue;

#pragma mark - Lib

typedef struct {
  COwner owner;
  CValue value;
} Lib;

const Lib* getLib(void);

CF_ASSUME_NONNULL_END

#endif
