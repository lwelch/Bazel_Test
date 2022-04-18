#include <stdio.h>
#include <stdbool.h>
// #include "mySharedLib.h"
// #include <windows.h>
#include <dlfcn.h>
#include <unistd.h>

typedef unsigned int(*ADD_PTR)(unsigned int, unsigned int);

int main(void)
{
    void *addLib;
    ADD_PTR add;

    bool success = false;
    unsigned int a = 1;
    unsigned int b = 2;
    unsigned int result = 0;

    addLib = dlopen("../shared_lib/libsharedLib.so", RTLD_LAZY);

    if (addLib != NULL)
    {
        printf("DLL Loaded!\n");
        add = (ADD_PTR)dlsym(addLib, "add");
        if (NULL != add)
        {
            success = true;
            result = add(a,b);
            printf("\n The result is [%u]\n",result);

        }
        dlclose(addLib);
    }

    if (!success) printf("Failed to load dll and call functions\n");

    return 0;
}