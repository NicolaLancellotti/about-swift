
#ifndef BazRef2_h
#define BazRef2_h

typedef struct {
    void* _Nonnull (* _Nonnull create) (const char* _Nonnull aString, int32_t anInteger);
    void (* _Nonnull release) (void* _Nonnull bazRef);
    void (* _Nonnull print) (void* _Nonnull bazRef);
    void (* _Nonnull setFooBar) (void* _Nonnull bazRef, void* _Nonnull foobarRef);
} CBaz;

typedef struct {
    void* _Nonnull (* _Nonnull create) (int32_t anInteger);
    void (* _Nonnull release) (void* _Nonnull foobarRef);
} CFooBar;

typedef struct {
    CBaz baz;
    CFooBar fooBar;
    
} Lib;

const Lib* _Nonnull getLib(void);

#endif
