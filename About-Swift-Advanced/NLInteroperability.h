
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NLInteroperability : NSObject

#pragma mark - Overriding Swift Names for Objective-C Interfaces

typedef NS_ENUM(NSInteger, ABCRecordSide) {
    ABCRecordSideA,
    ABCRecordSideB NS_SWIFT_NAME(FlipSide),
};

+ (instancetype)objectWithInteger:(NSInteger)value NS_SWIFT_NAME(init(int:));

#pragma mark - Making Objective-C Interfaces Unavailable in Swift

+ (instancetype)collectionWithValues:(NSArray *)values
                             forKeys:(NSArray<NSCopying> *)keys NS_SWIFT_UNAVAILABLE("Use a dictionary literal instead");

#pragma mark - Refining Objective-C Declarations
/*
 You can use the NS_REFINED_FOR_SWIFT macro on an Objective-C method declaration 
 to provide a refined Swift interface in an extension, while keeping the original 
 implementation available to be called from the refined interface
 */

- (void)getRed:(nullable CGFloat *)red
         green:(nullable CGFloat *)green
          blue:(nullable CGFloat *)blue
         alpha:(nullable CGFloat *)alpha NS_REFINED_FOR_SWIFT;

#pragma mark - Errors
/*
 Use the NS_SWIFT_NOTHROW macro on an Objective-C method declaration that
 produces an NSError to prevent it from being imported by Swift as a method that
 throws.
 */
- (BOOL)removeItemWithName:(NSString *)name
                     error:(NSError **)error NS_SWIFT_NOTHROW;

#pragma mark - Subscripts

- (NSString*)objectForKeyedSubscript:(NSInteger)key;

- (void)setObject:(NSString*)obj forKeyedSubscript:(NSInteger)key;

@end

#pragma mark - Enum

// Default
typedef NS_ENUM(NSInteger, NLNonFrozenEnum) {
    NLNonFrozenEnumCase1 = 1,
    NLNonFrozenEnumCase2,
} __attribute__((enum_extensibility(open)));;

typedef NS_ENUM(NSInteger, NLFrozenEnum) {
    NLFrozenEnumCase1 = 1,
    NLFrozenEnumCase2
} __attribute__((enum_extensibility(closed)));

NS_ASSUME_NONNULL_END

