#
# Copyright 2021 CNRS-UM LIRMM
#

# Try to find the MT Software Suite SDK for XSens
#
# This can use MTSDK_PREFIX as an hint
#
# Defines the mtsdk::<component> target, e.g
# - mtsdk::xstypes
# - mtsdk::xsensdeviceapi

if(NOT TARGET ${MTSDK})
  if(NOT DEFINED MTSDK_PREFIX)
    set(MTSDK_PREFIX ${CMAKE_INSTALL_PREFIX})
  endif()

  foreach(DEP ${mtsdk_FIND_COMPONENTS})
    message(STATUS "Looking for component ${DEP}")
    find_path(MTSDK_${DEP}_INCLUDE_DIR
      NAMES ${DEP}.h
      HINTS ${MTSDK_PREFIX}
      PATHS /usr/local
      PATH_SUFFIXES xsens/include
      )

    find_path(MTSDK_${DEP}_LIBRARY_DIR
      NAMES lib${DEP}.so
      HINTS ${MTSDK_PREFIX}
      PATHS /usr/local
      PATH_SUFFIXES xsens/lib
      )

    find_library(MTSDK_${DEP}_LIBRARY
      NAMES "${DEP}"
      PATHS ${MTSDK_PREFIX}
      PATHS /usr/local
      PATH_SUFFIXES xsens/lib
      )

    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(mtsdk DEFAULT_MSG MTSDK_${DEP}_LIBRARY MTSDK_${DEP}_INCLUDE_DIR)
    mark_as_advanced(MTSDK_${DEP}_INCLUDE_DIR MTSDK_${DEP}_LIBRARY)
    message("-- MTSDK_${DEP}_INCLUDE_DIR: ${MTSDK_${DEP}_INCLUDE_DIR}")
    message("-- MTSDK_${DEP}_LIBRARY: ${MTSDK_${DEP}_LIBRARY}")
    if(MTSDK_FOUND)
      add_library(mtsdk::${DEP} INTERFACE IMPORTED GLOBAL)
      set_target_properties(mtsdk::${DEP} PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${MTSDK_${DEP}_INCLUDE_DIR}"
        INTERFACE_LINK_LIBRARIES ${MTSDK_${DEP}_LIBRARY}
        )
    endif()
  endforeach()
endif()
