
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Variable Arguments

int cFuncWithVaList(int num_args, va_list arguments);

#pragma mark - withUnsafe[Mutable]Pointer

void increment(int* value);
int increment2(const int* value);
int sum(const int* value0, const int* value1);

NS_ASSUME_NONNULL_END
