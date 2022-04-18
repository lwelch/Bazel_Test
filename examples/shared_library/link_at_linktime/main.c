#include <stdio.h>
#include "mySharedLib.h"
int main(void)
{
    unsigned int a = 1;
    unsigned int b = 2;
    unsigned int result = 0;

    result = add(a,b);

    printf("\n The result is [%u]\n",result);
    return 0;
}