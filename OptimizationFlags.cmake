include_guard()

include(cmake/ArchitectureFlags.cmake)

set(OPTIM_DEBUG_FLAG "" CACHE STRING "")
mark_as_advanced(OPTIM_DEBUG_FLAG)
if (OPTIMIZATIONS_GENERATE_DEBUG_INFO)
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
        if (CMAKE_BUILD_TYPE MATCH "Release")
            message(STATUS "Including debug information: /Zi")
        endif()
        set(OPTIM_DEBUG_FLAG /Zi)
    else()
        message(STATUS "Including debug information: -g")
        set(OPTIM_DEBUG_FLAG -g)
    endif()
endif()

set(OPTIM_LEVEL_FLAG -O3 CACHE STRING "")
mark_as_advanced(OPTIM_LEVEL_FLAG)
if (OPTIMIZATIONS_USE_OFAST)
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
        # TODO
    else()
        message(STATUS "Using -Ofast")
        set(OPTIM_LEVEL_FLAG -Ofast)
    endif()
endif()

set(OPTIM_MEM_FLAG "" CACHE STRING "")
mark_as_advanced(OPTIM_MEM_FLAG)
if (OPTIMIZATIONS_USE_MEMORY_OPTIMIZATION)
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
        message(STATUS "Using Polly")
        set(OPTIM_MEM_FLAG "-mllvm -polly -mllvm -polly-vectorizer=stripmine")
    elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
        message(STATUS "Using Graphite")
        set(OPTIM_MEM_FLAG "-fgraphite-identity -floop-nest-optimize")
    elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Intel")
        # Nothing to do #
    elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
        # Nothing to do #
    endif()
endif()

set(OPTIM_FAST_MATH_FLAG "" CACHE STRING "")
mark_as_advanced(OPTIM_FAST_MATH_FLAG)
if (OPTIMIZATIONS_USE_FAST_MATH)
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
        set(OPTIM_FAST_MATH_FLAG /fp:fast)
    else()
        message(STATUS "Using -ffast-math")
        set(OPTIM_FAST_MATH_FLAG -ffast-math)
    endif()
endif()

set(OPTIM_LTO_FLAG "" CACHE STRING "")
mark_as_advanced(OPTIM_LTO_FLAG)
if (OPTIMIZATIONS_USE_LTO)
    message(STATUS "Using LTO")
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE)

    # on Linux, this seems to be necessary [https://gitlab.kitware.com/cmake/cmake/-/issues/20818]
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
        SET(CMAKE_AR ${CMAKE_CXX_COMPILER_AR} CACHE PATH "AR" FORCE)
        SET(CMAKE_RANLIB ${CMAKE_CXX_COMPILER_RANLIB} CACHE PATH "RANLIB" FORCE)
    endif()
endif()

set(OPTIM_FRAME_POINTER "" CACHE STRING "")
mark_as_advanced(OPTIM_FRAME_POINTER)
if (OPTIMIZATIONS_DO_NOT_OMIT_FRAME_POINTER)
	if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
		set(OPTIM_FRAME_POINTER "")
	else()
		message(STATUS "Omitting frame pointer: -fno-omit-frame-pointer")
		set(OPTIM_FRAME_POINTER -fno-omit-frame-pointer)
	endif()
endif()
set(OPTIM_NO_EXCEPTIONS "" CACHE STRING "")
mark_as_advanced(OPTIM_NO_EXCEPTIONS)
if (OPTIMIZATIONS_DISABLE_EXCEPTIONS)
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
        set(OPTIM_NO_EXCEPTIONS "")
    else()
        message(STATUS "Disabling exceptions: -fno-exceptions")
        set(OPTIM_NO_EXCEPTIONS -fno-exceptions)
    endif()
endif()

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    set(CMAKE_CXX_FLAGS_RELEASE "${ARCHI_FLAG} ${OPTIM_DEBUG_FLAG} ${OPTIM_LEVEL_FLAG} ${OPTIM_FRAME_POINTER} ${OPTIM_NO_EXCEPTIONS} ${OPTIM_MEM_FLAG} ${OPTIM_FAST_MATH_FLAG} ${RTTI_FLAGS}" CACHE STRING "" FORCE)
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    set(CMAKE_CXX_FLAGS_RELEASE "${ARCHI_FLAG} ${OPTIM_DEBUG_FLAG} ${OPTIM_LEVEL_FLAG} ${OPTIM_FRAME_POINTER} ${OPTIM_NO_EXCEPTIONS} ${OPTIM_MEM_FLAG} ${OPTIM_FAST_MATH_FLAG} ${RTTI_FLAGS}" CACHE STRING "" FORCE)
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Intel")
    set(CMAKE_CXX_FLAGS_RELEASE "${ARCHI_FLAG} ${OPTIM_DEBUG_FLAG} ${OPTIM_LEVEL_FLAG} ${OPTIM_FRAME_POINTER} ${OPTIM_NO_EXCEPTIONS} ${OPTIM_MEM_FLAG} ${OPTIM_FAST_MATH_FLAG} ${RTTI_FLAGS}" CACHE STRING "" FORCE)
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    set(CMAKE_CXX_FLAGS_RELEASE "${ARCHI_FLAG} ${OPTIM_DEBUG_FLAG} ${OPTIM_LEVEL_FLAG} ${OPTIM_FRAME_POINTER} ${OPTIM_NO_EXCEPTIONS} ${OPTIM_MEM_FLAG} ${OPTIM_FAST_MATH_FLAG} ${RTTI_FLAGS}" CACHE STRING "" FORCE)
endif()

mark_as_advanced(CMAKE_CXX_FLAGS_RELEASE)
