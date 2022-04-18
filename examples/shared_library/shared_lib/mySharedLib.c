#include "mySharedLib.h"
#include <stdio.h>
DLLEXPORT unsigned int add(unsigned int a, unsigned int b)
{
    printf("\n Inside add()\n");
    return (a+b);
}