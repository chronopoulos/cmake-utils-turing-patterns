include_guard()

include(cmake/ArchitectureFlags.cmake)

set(OPTIM_DEBUG_FLAG "")
mark_as_advanced(OPTIM_DEBUG_FLAG)
if (OPTIMIZATIONS_GENERATE_DEBUG_INFO)
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
        set(OPTIM_DEBUG_FLAG /Zi)
    else()
        set(OPTIM_DEBUG_FLAG -g)
    endif()
endif()

set(OPTIM_LEVEL_FLAG -O3)
mark_as_advanced(OPTIM_LEVEL_FLAG)
if (OPTIMIZATIONS_USE_OFAST)
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
        # TODO
    else()
        set(OPTIM_LEVEL_FLAG -Ofast)
    endif()
endif()

set(OPTIM_MEM_FLAG "")
mark_as_advanced(OPTIM_MEM_FLAG)
if (OPTIMIZATIONS_USE_MEMORY_OPTIMIZATION)
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
        message(STATUS "Using Polly")
        set(OPTIM_MEM_FLAG -mllvm -polly -mllvm -polly-vectorizer=stripmine)
    elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
        message(STATUS "Using Graphite")
        set(OPTIM_MEM_FLAG -fgraphite-identity -floop-nest-optimize)
    elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Intel")
        # Nothing to do #
    elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
        # Nothing to do #
    endif()
endif()

set(OPTIM_FAST_MATH_FLAG "")
mark_as_advanced(OPTIM_FAST_MATH_FLAG)
if (OPTIMIZATIONS_USE_FAST_MATH)
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
        set(OPTIM_FAST_MATH_FLAG /fp:fast)
    else()
        set(OPTIM_FAST_MATH_FLAG -ffast-math)
    endif()
endif()

set(OPTIM_LTO_FLAG "")
mark_as_advanced(OPTIM_LTO_FLAG)
if (OPTIMIZATIONS_USE_LTO)
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE)
endif()

set(OPTIM_FRAME_POINTER "")
mark_as_advanced(OPTIM_FRAME_POINTER)
if (CMAKE_BUILD_TYPE STREQUAL "Profile")
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
        set(OPTIM_FRAME_POINTER "")
    else()
        set(OPTIM_FRAME_POINTER -fno-omit-frame-pointer)
    endif()
endif()


mark_as_advanced(CMAKE_CXX_FLAGS_RELEASE)

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    set(CMAKE_CXX_FLAGS_RELEASE "${ARCHI_FLAG} ${OPTIM_DEBUG_FLAG} ${OPTIM_LEVEL_FLAG} ${OPTIM_FRAME_POINTER} ${OPTIM_MEM_FLAG} ${OPTIM_FAST_MATH_FLAG}" CACHE STRING "" FORCE)
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    set(CMAKE_CXX_FLAGS_RELEASE "${ARCHI_FLAG} ${OPTIM_DEBUG_FLAG} ${OPTIM_LEVEL_FLAG} ${OPTIM_FRAME_POINTER} ${OPTIM_MEM_FLAG} ${OPTIM_FAST_MATH_FLAG}" CACHE STRING "" FORCE)
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Intel")
    set(CMAKE_CXX_FLAGS_RELEASE "${ARCHI_FLAG} ${OPTIM_DEBUG_FLAG} ${OPTIM_LEVEL_FLAG} ${OPTIM_FRAME_POINTER} ${OPTIM_MEM_FLAG} ${OPTIM_FAST_MATH_FLAG}" CACHE STRING "" FORCE)
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    set(CMAKE_CXX_FLAGS_RELEASE "${ARCHI_FLAG} ${OPTIM_DEBUG_FLAG} ${OPTIM_LEVEL_FLAG} ${OPTIM_FRAME_POINTER} ${OPTIM_MEM_FLAG} ${OPTIM_FAST_MATH_FLAG}" CACHE STRING "" FORCE)
endif()
