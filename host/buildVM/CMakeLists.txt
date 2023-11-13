cmake_minimum_required(VERSION 3.5)
project(buildvm C)
add_executable(buildvm
    ${LUAJIT_DIR}/src/host/buildvm_asm.c
    ${LUAJIT_DIR}/src/host/buildvm_fold.c
    ${LUAJIT_DIR}/src/host/buildvm_lib.c
    ${LUAJIT_DIR}/src/host/buildvm_peobj.c
    ${LUAJIT_DIR}/src/host/buildvm.c
)
target_include_directories(buildvm PUBLIC
    ${LUAJIT_DIR}/src
    ${LUAJIT_DIR}/src/host
)

set(files lib_base.c lib_math.c lib_bit.c lib_string.c lib_table.c lib_io.c lib_os.c lib_package.c lib_debug.c lib_jit.c lib_ffi.c lib_buffer.c)
set(lib_sources "")

foreach(file ${files})
    list(APPEND lib_sources ${LUAJIT_DIR}/src/${file})
endforeach()

add_custom_command(TARGET buildvm POST_BUILD COMMAND buildvm -m peobj -o ${LUAJIT_DIR}/src/lj_vm.obj)
add_custom_command(TARGET buildvm POST_BUILD COMMAND buildvm -m bcdef -o ${LUAJIT_DIR}/src/lj_bcdef.h ${lib_sources})
add_custom_command(TARGET buildvm POST_BUILD COMMAND buildvm -m ffdef -o ${LUAJIT_DIR}/src/lj_ffdef.h ${lib_sources})
add_custom_command(TARGET buildvm POST_BUILD COMMAND buildvm -m libdef -o ${LUAJIT_DIR}/src/lj_libdef.h ${lib_sources})
add_custom_command(TARGET buildvm POST_BUILD COMMAND buildvm -m recdef -o ${LUAJIT_DIR}/src/lj_recdef.h ${lib_sources})
add_custom_command(TARGET buildvm POST_BUILD COMMAND buildvm -m vmdef -o ${LUAJIT_DIR}/src/jit/vmdef.lua ${lib_sources})
add_custom_command(TARGET buildvm POST_BUILD COMMAND buildvm -m folddef -o ${LUAJIT_DIR}/src/lj_folddef.h ${LUAJIT_DIR}/src/lj_opt_fold.c)