#include "ImportC.h"

#pragma mark - Variable arguments

int cFunctionWithVaList(int32_t argc, va_list arguments)
{
  int32_t sum = 0;
  for(int i = 0; i < argc; ++i) {
    sum += va_arg(arguments, int);
  }
  return sum;
}
