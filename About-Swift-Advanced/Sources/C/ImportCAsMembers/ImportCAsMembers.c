#include "ImportCAsMembers.h"

const ImportCAsMembers DefaultValue = (ImportCAsMembers){._value = 10};

ImportCAsMembers ImportCAsMembersCreate(int32_t value)
{
  return (ImportCAsMembers){._value = value};
}

int ImportCAsMembersGetValue(ImportCAsMembers const *instance)
{
  return instance->_value;
}

void ImportCAsMembersSetValue(ImportCAsMembers *instance, int32_t value)
{
  instance->_value = value;
}

int ImportCAsMembersIncrementedBy(ImportCAsMembers const *instance, int32_t value)
{
  return instance->_value + value;
}
