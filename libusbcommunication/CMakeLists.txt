cmake_minimum_required(VERSION 3.4.1)

project(commu-mx C)

message("Using libusb path ${LIBUSB_PATH}")

set(LIBUSB_SRC "${LIBUSB_PATH}/libusb")
set(LIBUSB_INCLUDE "${LIBUSB_PATH}")


include_directories(${LIBUSB_INCLUDE}/android/)  # config.h
include_directories(${LIBUSB_SRC})
add_library( libusb
             SHARED
             ${LIBUSB_SRC}/core.c
             ${LIBUSB_SRC}/strerror.c
             ${LIBUSB_SRC}/descriptor.c
             ${LIBUSB_SRC}/hotplug.c
             ${LIBUSB_SRC}/io.c
             ${LIBUSB_SRC}/sync.c
             ${LIBUSB_SRC}/os/linux_usbfs.c
             ${LIBUSB_SRC}/os/events_posix.c
             ${LIBUSB_SRC}/os/threads_posix.c
             ${LIBUSB_SRC}/os/linux_netlink.c)

set_target_properties(libusb PROPERTIES CXX_VISIBILITY_PRESET hidden)
target_link_options(libusb PRIVATE
        "-Wl,--version-script=${CMAKE_SOURCE_DIR}/version_script_libusb"
)
target_link_libraries(libusb log)


include_directories(${LIBUSB_INCLUDE})
add_library( libcommu-mx
             SHARED
             src/c/usb_fork.c )

set_target_properties(libcommu-mx PROPERTIES CXX_VISIBILITY_PRESET hidden)
target_compile_options(libcommu-mx PRIVATE
        -Wno-error=int-conversion
)
target_link_options(libcommu-mx PRIVATE
        "-Wl,--version-script=${CMAKE_SOURCE_DIR}/version_script"
)

target_link_libraries(libcommu-mx libusb log)
