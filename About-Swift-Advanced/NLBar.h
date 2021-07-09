#ifndef NLBar_h
#define NLBar_h

#include <CoreFoundation/CoreFoundation.h>

CF_ASSUME_NONNULL_BEGIN

typedef struct {
  int _value;
} NLBar;

CF_SWIFT_NAME(NLBar.defaultValue)
extern const NLBar NLDefaultValue;

CF_SWIFT_NAME(NLBar.init(value:))
NLBar NLBarCreate(int value);

CF_SWIFT_NAME(getter:NLBar.value(self:))
int NLBarGetValue(const NLBar* bar);

CF_SWIFT_NAME(setter:NLBar.value(self:newValue:))
void NLBarSetValue(NLBar* bar, int value);

CF_SWIFT_NAME(NLBar.incremented(self:by:))
int NLBarIncrementedBy(const NLBar* bar, int value);

#endif

CF_ASSUME_NONNULL_END
