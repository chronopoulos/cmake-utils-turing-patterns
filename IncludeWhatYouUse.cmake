include_guard()

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    find_program(IWYU_PROGRAM iwyu)
    mark_as_advanced(IWYU_PROGRAM)

    set(CMAKE_CXX_INCLUDE_WHAT_YOU_USE "${IWYU_PROGRAM};-Xiwyu;any;-Xiwyu;iwyu;-Xiwyu;args" CACHE STRING "" FORCE)
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    message(FATAL "gcc not supported")
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Intel")
    message(FATAL "icc not supported")
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    message(FATAL "MSVC not supported")
endif()