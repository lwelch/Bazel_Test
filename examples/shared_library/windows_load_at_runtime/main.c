#include <stdio.h>
#include <stdbool.h>
// #include "mySharedLib.h"
#include <windows.h>

typedef unsigned int(__cdecl *ADD_PTR)(unsigned int, unsigned int);

int main(void)
{
    HINSTANCE addLib;
    ADD_PTR add;

    bool success = FALSE;
    unsigned int a = 1;
    unsigned int b = 2;
    unsigned int result = 0;

    addLib = LoadLibrary(TEXT("../shared_lib/sharedLib.dll"));

    if (addLib != NULL)
    {
        printf("DLL Loaded!\n");
        add = (ADD_PTR)GetProcAddress(addLib, "add");
        if (NULL != add)
        {
            success = TRUE;
            result = add(a,b);
            printf("\n The result is [%u]\n",result);

        }
        FreeLibrary(addLib);
    }

    if (!success) printf("Failed to load dll and call functions\n");

    return 0;
}