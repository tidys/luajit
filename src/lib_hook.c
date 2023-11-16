#include "lib_hook.h";

extern void setHookFunction(void(*func))
{
    hookFunction = func;
}

void emitHookFunction()
{
    if (hookFunction)
    {
        hookFunction();
    }
}