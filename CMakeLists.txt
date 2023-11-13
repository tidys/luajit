cmake_minimum_required(VERSION 3.5)
set(app_name luajit)
project(${app_name})
set(LUAJIT_DIR ${CMAKE_CURRENT_LIST_DIR})

# add mini exe
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/host/minilua/)

# add buildVM
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/host/buildVM/)

file(GLOB_RECURSE src ${CMAKE_CURRENT_LIST_DIR}/src/lj_*.c ${CMAKE_CURRENT_LIST_DIR}/src/lib_*.c)

add_library(${app_name} SHARED ${src})
set_target_properties(${app_name} PROPERTIES OUTPUT_NAME "lua51")
target_include_directories(${app_name} PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src)

# target_compile_options(${app_name} PUBLIC "/O2")