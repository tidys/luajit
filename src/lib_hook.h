#ifndef __LIBHOOK__
#define __LIBHOOK__
#ifdef __cplusplus
extern "C" {
#endif
void (*hookFunction)();
extern __declspec(dllexport) void setHookFunction(void(*func));
void emitHookFunction();
#ifdef __cplusplus
}
#endif
#endif