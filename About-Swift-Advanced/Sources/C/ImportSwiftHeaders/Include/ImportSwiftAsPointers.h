#ifndef ImportSwift12_h
#define ImportSwift12_h

#include <stdint.h>

typedef struct Owner* OwnerRef;
typedef struct Value* ValueRef;

#pragma mark - Owner

typedef struct {
  OwnerRef _Nonnull (* _Nonnull create) (const char* _Nonnull string,
                                         int32_t integer);
  void (* _Nonnull release) (OwnerRef _Nonnull instanceRef);
  void (* _Nonnull dump) (OwnerRef _Nonnull instanceRef);
  void (* _Nonnull setValue) (OwnerRef _Nonnull instanceRef,
                              ValueRef _Nonnull valueRef);
} COwner;

#pragma mark - Value

typedef struct {
  ValueRef _Nonnull (* _Nonnull create) (int32_t anInteger);
  void (* _Nonnull release) (ValueRef _Nonnull instanceRef);
} CValue;

#pragma mark - Lib

typedef struct {
  COwner owner;
  CValue value;
} Lib;

const Lib* _Nonnull getLib(void);

#endif
