#import "CFunctions.h"
#include <stdarg.h>

#pragma mark - Variable Arguments

int cFuncWithVaList(int num_args, va_list arguments)
{
  int sum = 0;
  for(int i = 0; i < num_args; ++i) {
    sum += va_arg(arguments, int);
  }
  return sum;
}

#pragma mark - withUnsafe[Mutable]Pointer

void increment(int* value)
{
  *value += 1;
}

int increment2(const int* value)
{
  return *value + 1;
}

int sum(const int* value0, const int* value1)
{
  return *value0 + *value1;
}
