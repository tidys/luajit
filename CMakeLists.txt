cmake_minimum_required(VERSION 3.5)
project(luajit)
set(LUAJIT_DIR ${CMAKE_CURRENT_LIST_DIR})

# add mini exe
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/host/minilua/)
 
# add buildVM
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/host/buildVM/)
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/host/lua51)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /nologo /c /O2 /W3 /D_CRT_SECURE_NO_DEPRECATE /D_CRT_STDIO_INLINE=__declspec(dllexport)__inline /arch:SSE2")

add_executable(luajit ${LUAJIT_DIR}/src/luajit.c)
target_include_directories(luajit PUBLIC ${LUAJIT_DIR}/src)

# add lua51.dll
if(true)
    add_library(lua51 SHARED IMPORTED GLOBA)
    set_target_properties(lua51 PROPERTIES
        IMPORTED_IMPLIB ${LUAJIT_DIR}/src/lua51.lib
        IMPORTED_LOCATION ${LUAJIT_DIR}/src/lua51.dll
    )
    file(GLOB lua51dll ${LUAJIT_DIR}/src/*.dll)
    add_custom_command(TARGET luajit PRE_BUILD COMMAND ${CMAKE_COMMAND} -E copy ${lua51dll} $(OutDir))

    # set_property(TARGET luajit PROPERTY VS_DEBUGGER_COMMAND_ARGUMENTS "$<IF:$<CONFIG:Release>,release,debug>")
endif()

target_link_libraries(luajit lua51)
set_target_properties(luajit minilua luajitSourceCode buildvm PROPERTIES FOLDER "luajit")
# add_custom_command(TARGET luajit PRE_BUILD COMMAND cl  /nologo /c /O2 /W3 /D_CRT_SECURE_NO_DEPRECATE /D_CRT_STDIO_INLINE="__declspec(dllexport)__inline" /arch:SSE2 /MD /DLUA_BUILD_AS_DLL ${LUAJIT_DIR}/src/lj_*.c ${LUAJIT_DIR}/src/lib_*.c /Fo ${LUAJIT_DIR}/src/)
# add_custom_command(TARGET luajit PRE_BUILD COMMAND link /nologo /release /DLL /out:${LUAJIT_DIR}/src/lua51.dll ${LUAJIT_DIR}/src/lj_*.obj ${LUAJIT_DIR}/src/lib_*.obj)