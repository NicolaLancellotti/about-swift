#import "NLInteroperability.h"

@implementation NLInteroperability


+ (instancetype)objectWithInteger:(NSInteger)value;
{
  return [NLInteroperability new];
}

#pragma mark - Making Objective-C Interfaces Unavailable in Swift

+ (instancetype)collectionWithValues:(NSArray *)values
                             forKeys:(NSArray<NSCopying> *)keys
{
  return [NLInteroperability new];;
}

#pragma mark - Refining Objective-C Declarations

- (void)getRed:(nullable CGFloat *)red
         green:(nullable CGFloat *)green
          blue:(nullable CGFloat *)blue
         alpha:(nullable CGFloat *)alpha
{
  
}

#pragma mark - Errors

- (BOOL)removeItemWithName:(NSString *)name
                     error:(NSError **)error
{
  return YES;
}

#pragma mark - Subscripts

- (NSString*)objectForKeyedSubscript:(NSInteger)key
{
  return @"";
}

- (void)setObject:(NSString*)obj forKeyedSubscript:(NSInteger)key
{
  
}
@end
