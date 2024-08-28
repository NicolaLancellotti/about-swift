#ifndef ImportCAsOpaque_h
#define ImportCAsOpaque_h

#include <CoreFoundation/CoreFoundation.h>
#include <stdint.h>

CF_ASSUME_NONNULL_BEGIN

typedef struct ImportCAsOpaque *ImportCAsOpaqueRef;

ImportCAsOpaqueRef ImportCAsOpaqueCreate(int32_t value);

int32_t ImportCAsOpaqueGetValue(const ImportCAsOpaqueRef instance);

void ImportCAsOpaqueSetValue(ImportCAsOpaqueRef instance, int32_t value);

void ImportCAsOpaqueRelease(ImportCAsOpaqueRef instance);

#endif

CF_ASSUME_NONNULL_END
