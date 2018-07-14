
#include "NLBar.h"

const NLBar NLDefaultValue = (NLBar){._value = 10};

NLBar NLBarCreate(int value)
{
    return (NLBar){._value = value};
}

int NLBarGetValue(NLBar const *bar)
{
    return bar->_value;
}

void NLBarSetValue(NLBar *bar, int value)
{
    bar->_value = value;
}

int NLBarIncrementedBy(NLBar const *bar, int value)
{
    return bar->_value + value;
}
