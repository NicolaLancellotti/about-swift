#ifndef ImportC_h
#define ImportC_h

#include <CoreFoundation/CoreFoundation.h>
#include <stdint.h>
#include <stdarg.h>

CF_ASSUME_NONNULL_BEGIN

#pragma mark - Variable arguments

int32_t cFunctionWithVaList(int32_t argc, va_list arguments);

CF_ASSUME_NONNULL_END

#endif
