
#ifndef BazRef2_h
#define BazRef2_h

typedef struct CBazType* CBazRef;
typedef struct CFooBarType* CFooBarRef;

typedef struct {
    CBazRef _Nonnull (* _Nonnull create) (const char* _Nonnull aString, int32_t anInteger);
    void (* _Nonnull release) (CBazRef _Nonnull bazRef);
    void (* _Nonnull print) (CBazRef _Nonnull bazRef);
    void (* _Nonnull setFooBar) (CBazRef _Nonnull bazRef, CFooBarRef _Nonnull foobarRef);
} CBaz;

typedef struct {
    CFooBarRef _Nonnull (* _Nonnull create) (int32_t anInteger);
    void (* _Nonnull release) (CFooBarRef _Nonnull foobarRef);
} CFooBar;

typedef struct {
    CBaz baz;
    CFooBar fooBar;
    
} Lib;

const Lib* _Nonnull getLib(void);

#endif
