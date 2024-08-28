#ifndef ImportCAsMembers_h
#define ImportCAsMembers_h

#include <CoreFoundation/CoreFoundation.h>
#include <stdint.h>

CF_ASSUME_NONNULL_BEGIN

typedef struct {
  int _value;
} ImportCAsMembers;

CF_SWIFT_NAME(ImportCAsMembers.default)
extern const ImportCAsMembers DefaultValue;

CF_SWIFT_NAME(ImportCAsMembers.init(value:))
ImportCAsMembers ImportCAsMembersCreate(int32_t value);

CF_SWIFT_NAME(getter:ImportCAsMembers.value(self:))
int ImportCAsMembersGetValue(const ImportCAsMembers* instance);

CF_SWIFT_NAME(setter:ImportCAsMembers.value(self:newValue:))
void ImportCAsMembersSetValue(ImportCAsMembers* instance, int32_t value);

CF_SWIFT_NAME(ImportCAsMembers.incremented(self:by:))
int ImportCAsMembersIncrementedBy(const ImportCAsMembers* instance, int32_t value);

#endif

CF_ASSUME_NONNULL_END
