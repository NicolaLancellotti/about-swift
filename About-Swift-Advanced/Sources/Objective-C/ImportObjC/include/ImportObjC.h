#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImportObjC : NSObject

#pragma mark - Overriding Swift Names for Objective-C Interfaces

+ (instancetype)objectWithInteger:(NSInteger)value NS_SWIFT_NAME(init(value:));

#pragma mark - Making Objective-C Interfaces Unavailable in Swift

+ (instancetype)collectionWithValues:(NSArray *)values
                             forKeys:(NSArray<NSCopying> *)keys NS_SWIFT_UNAVAILABLE("Use a dictionary literal instead");

#pragma mark - Refining Objective-C Declarations
/*
 You can use the NS_REFINED_FOR_SWIFT macro on an Objective-C method declaration
 to provide a refined Swift interface in an extension, while keeping the
 original implementation available to be called from the refined interface
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

#pragma mark - Enums

// Default
typedef NS_ENUM(NSInteger, ImportObjCNonFrozenEnum) {
  ImportObjCNonFrozenEnumCase1 = 1,
  ImportObjCNonFrozenEnumCase2,
} __attribute__((enum_extensibility(open)));;

// A nonfrozen enumeration is a special kind of enumeration that may gain new
// enumeration cases in the future
// Only the standard library, Swift overlays for Apple frameworks, and C and
// Objective-C code can declare nonfrozen enumerations.
typedef NS_ENUM(NSInteger, ImportObjCFrozenEnum) {
  ImportObjCFrozenEnumCase1 NS_SWIFT_NAME(caseA) = 1,
  ImportObjCFrozenEnumCase2
} __attribute__((enum_extensibility(closed)));

NS_ASSUME_NONNULL_END
