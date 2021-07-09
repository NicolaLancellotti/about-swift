#include "NLFoo.h"

struct NLFoo {
  int value;
};

NLFooRef NLFooCreate(int value)
{
  NLFooRef foo = calloc(1, sizeof(struct NLFoo));
  foo->value = value;
  return foo;
}

int NLFooGetValue(NLFooRef foo)
{
  return foo->value;
}

void NLFooSetValue(NLFooRef foo, int value)
{
  foo->value = value;
}

void NLFooRelease(NLFooRef foo)
{
  free(foo);
}
