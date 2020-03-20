include_guard(GLOBAL)

cmake_minimum_required(VERSION 3.14)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")

include(cmake/Options.cmake)
include(cmake/CudaFlags.cmake)
include(cmake/MklFlags.cmake)
include(cmake/BlasFlags.cmake)
include(cmake/OpenBlasFlags.cmake)
include(cmake/Flags.cmake)
include(cmake/Warnings.cmake)
include(cmake/Common.cmake)
include(cmake/TargetUtilities.cmake)
