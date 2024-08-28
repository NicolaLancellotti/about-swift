#include "ImportCAsOpaque.h"

struct ImportCAsOpaque {
  int32_t value;
};

ImportCAsOpaqueRef ImportCAsOpaqueCreate(int32_t value)
{
  ImportCAsOpaqueRef instance = calloc(1, sizeof(struct ImportCAsOpaque));
  instance->value = value;
  return instance;
}

int32_t ImportCAsOpaqueGetValue(ImportCAsOpaqueRef instance)
{
  return instance->value;
}

void ImportCAsOpaqueSetValue(ImportCAsOpaqueRef instance, int value)
{
  instance->value = value;
}

void ImportCAsOpaqueRelease(ImportCAsOpaqueRef instance)
{
  free(instance);
}
