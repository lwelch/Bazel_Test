#include<stdio.h>
#ifdef WINDOWS_OS
#ifdef COMPILING_DLL
#define DLLEXPORT __declspec(dllexport)
#else
#define DLLEXPORT __declspec(dllimport)
#endif
#else
#define DLLEXPORT
#endif

extern DLLEXPORT unsigned int add(unsigned int a, unsigned int b);