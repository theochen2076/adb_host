# Makefile for adb; based on core/adb/Android.mk
SRCS+=  ./adb/adb.cpp 
SRCS+=   ./adb/adb_io.cpp 
SRCS+=   ./adb/adb_listeners.cpp 
SRCS+=   ./adb/adb_trace.cpp 
SRCS+=   ./adb/adb_utils.cpp 
SRCS+=   ./adb/fdevent.cpp 
SRCS+=   ./adb/sockets.cpp 
SRCS+=   ./adb/socket_spec.cpp 
SRCS+=   ./adb/sysdeps/errno.cpp 
SRCS+=   ./adb/transport.cpp 
SRCS+=   ./adb/transport_local.cpp 
SRCS+=   ./adb/transport_usb.cpp 
SRCS+=   ./adb/sysdeps_unix.cpp 
SRCS+=   ./adb/sysdeps/posix/network.cpp 
SRCS+=   ./adb/client/usb_dispatch.cpp 
SRCS+=   ./adb/client/usb_libusb.cpp 
SRCS+=   ./adb/client/usb_linux.cpp 
SRCS+=   ./adb/adb_client.cpp 
SRCS+=   ./adb/bugreport.cpp 
SRCS+=   ./adb/client/main.cpp 
SRCS+=   ./adb/console.cpp 
SRCS+=   ./adb/commandline.cpp 
SRCS+=   ./adb/file_sync_client.cpp 
SRCS+= 	 ./adb/transport_mdns_unsupported.cpp 
SRCS+=   ./adb/adb_auth_host.cpp 
SRCS+=   ./adb/line_printer.cpp 
SRCS+=   ./adb/services.cpp 
SRCS+=   ./adb/shell_service_protocol.cpp
SRCS+=   ./adb/diagnose_usb.cpp
SRCS+=   ./libcrypto_utils/android_pubkey.c 
SRCS+=   ./libusb/libusb/core.c 
SRCS+=   ./libusb/libusb/hotplug.c 
SRCS+=   ./libusb/libusb/strerror.c
SRCS+=   ./libusb/libusb/descriptor.c 
SRCS+=   ./libusb/libusb/io.c 
SRCS+=   ./libusb/libusb/sync.c 
SRCS+=   ./libusb/libusb/os/linux_usbfs.c 
SRCS+=   ./libusb/libusb/os/poll_posix.c 
SRCS+=   ./libusb/libusb/os/threads_posix.c 
SRCS+=   ./libusb/libusb/os/linux_netlink.c 

SRCS+= ./libcutils/sockets.cpp
SRCS+= ./libcutils/socket_inaddr_any_server_unix.c
SRCS+= ./libcutils/socket_local_client_unix.c
SRCS+= ./libcutils/socket_local_server_unix.c
SRCS+= ./libcutils/socket_loopback_client_unix.c
SRCS+= ./libcutils/socket_loopback_server_unix.c
SRCS+= ./libcutils/socket_network_client_unix.c
SRCS+= ./libcutils/load_file.c

SRCS+= ./base/file.cpp 
SRCS+= ./base/logging.cpp 
SRCS+= ./base/parsenetaddress.cpp 
SRCS+= ./base/stringprintf.cpp 
SRCS+= ./base/strings.cpp 
SRCS+= ./base/errors_unix.cpp 

CPPFLAGS+= -D_GLIBCXX_USE_CXX11_ABI=0
CPPFLAGS+= -D_LIBCPP_STD_VER=18
CPPFLAGS+= -DADB_HOST=1
CPPFLAGS+= -DADB_VERSION='"28.0.0"'
CPPFLAGS+= -DHAVE_FORKEXEC=1
CPPFLAGS+= -DHAVE_SYMLINKS
CPPFLAGS+= -DHAVE_TERMIO_H

CPPFLAGS+= -I./include
CPPFLAGS+= -DHAVE_PTHREADS
CPPFLAGS+= -L./libcrypto

LIBS+=  -lc   -lpthread -lm -no-pie  
OBJS= $(SRCS:.c=.o)
CC=gcc
#CC=arm-linux-gnueabihf-gcc
#CC=aarch64-linux-gnu-gcc

TARGET=x86
#TARGET=arm32
#TARGET=arm64
all:  adb_$(TARGET)


	# @rm  $(filter %.o,$(OBJS)) 
adb_$(TARGET): $(OBJS) ./libcrypto/libcrypto_$(TARGET).a
	$(CC) -o $@ $(OBJS) $(LIBS) $(CPPFLAGS) $(LIBS)  -Wl,-Bstatic -lcrypto_$(TARGET) -lstdc++  -Wl,-Bdynamic -std=c++1z
	@echo "============build finish adb_$(TARGET)=============="
clean:
	rm -f adb_*
