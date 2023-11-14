cmake_minimum_required(VERSION 3.5)
set(app_name "luajitSourceCode")
project(${app_name})
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /nologo /c /O2 /W3 /D_CRT_SECURE_NO_DEPRECATE /D_CRT_STDIO_INLINE=__declspec(dllexport)__inline /arch:SSE2 /MD /DLUA_BUILD_AS_DLL")
file(GLOB_RECURSE src
    ${LUAJIT_DIR}/src/lj_*.c
    ${LUAJIT_DIR}/src/lj_*.h
    ${LUAJIT_DIR}/src/lib_*.c
    ${LUAJIT_DIR}/src/lib_*.h
)
source_group(TREE ${LUAJIT_DIR} FILES ${src})
add_library(${app_name} SHARED ${src})
set_target_properties(${app_name} PROPERTIES OUTPUT_NAME "lua51")
target_include_directories(${app_name} PUBLIC ${LUAJIT_DIR}/src)

# target_compile_definitions( PUBLIC "LUA_BUILD_AS_DLL")
# target_compile_definitions(${app_name} PUBLIC "_CRT_STDIO_INLINE=__declspec(dllexport)__inline")
# target_compile_definitions(${app_name} PUBLIC "_CRT_SECURE_NO_DEPRECATE")