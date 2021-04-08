# Makefile for adb; based on core/adb/Android.mk
SRCS+=   adb.cpp 
SRCS+=   adb_io.cpp 
SRCS+=   adb_listeners.cpp 
SRCS+=   adb_trace.cpp 
SRCS+=   adb_utils.cpp 
SRCS+=   fdevent.cpp 
SRCS+=   sockets.cpp 
SRCS+=   socket_spec.cpp 
SRCS+=   sysdeps/errno.cpp 
SRCS+=   transport.cpp 
SRCS+=   transport_local.cpp 
SRCS+=   transport_usb.cpp 
SRCS+=   sysdeps_unix.cpp 
SRCS+=   sysdeps/posix/network.cpp 
SRCS+=   client/usb_dispatch.cpp 
SRCS+=   client/usb_libusb.cpp 
SRCS+=   client/usb_linux.cpp 
SRCS+=   adb_client.cpp 
SRCS+=   bugreport.cpp 
SRCS+=   client/main.cpp 
SRCS+=   console.cpp 
SRCS+=   commandline.cpp 
SRCS+=   file_sync_client.cpp 
SRCS+= 	 transport_mdns_unsupported.cpp 
SRCS+=   adb_auth_host.cpp 
SRCS+=   line_printer.cpp 
SRCS+=   services.cpp 
SRCS+=   shell_service_protocol.cpp
SRCS+=   diagnose_usb.cpp
SRCS+=   ../libcrypto_utils/android_pubkey.c 
SRCS+=   ../libusb/libusb/core.c 
SRCS+=   ../libusb/libusb/hotplug.c 
SRCS+=   ../libusb/libusb/strerror.c 
SRCS+=   ../libusb/libusb/descriptor.c 
SRCS+=   ../libusb/libusb/io.c 
SRCS+=   ../libusb/libusb/sync.c 
SRCS+=   ../libusb/libusb/os/linux_usbfs.c 
SRCS+=   ../libusb/libusb/os/poll_posix.c 
SRCS+=   ../libusb/libusb/os/threads_posix.c 
SRCS+=    ../libusb/libusb/os/linux_netlink.c 

SRCS+= ../libcutils/sockets.cpp
SRCS+= ../libcutils/socket_inaddr_any_server_unix.c
SRCS+= ../libcutils/socket_local_client_unix.c
SRCS+= ../libcutils/socket_local_server_unix.c
SRCS+= ../libcutils/socket_loopback_client_unix.c
SRCS+= ../libcutils/socket_loopback_server_unix.c
SRCS+= ../libcutils/socket_network_client_unix.c
SRCS+= ../libcutils/load_file.c

SRCS+= ../base/file.cpp 
SRCS+= ../base/logging.cpp 
SRCS+= ../base/parsenetaddress.cpp 
SRCS+= ../base/stringprintf.cpp 
SRCS+= ../base/strings.cpp 
SRCS+= ../base/errors_unix.cpp 

CPPFLAGS+= -D_GLIBCXX_USE_CXX11_ABI=0
CPPFLAGS+= -D_LIBCPP_STD_VER=18
CPPFLAGS+= -DADB_HOST=1
CPPFLAGS+= -DADB_VERSION='"28.0.0"'
CPPFLAGS+= -DHAVE_FORKEXEC=1
CPPFLAGS+= -DHAVE_SYMLINKS
CPPFLAGS+= -DHAVE_TERMIO_H
CPPFLAGS+= -I.
CPPFLAGS+= -I../adb
CPPFLAGS+= -I../include
CPPFLAGS+= -I../libusb/
CPPFLAGS+= -I../libusb/libusb
CPPFLAGS+= -I../core/base/include
CPPFLAGS+= -I../base/include 
CPPFLAGS+= -I../../../external/zlib
CPPFLAGS+= -DHAVE_PTHREADS
CPPFLAGS+= -L.

LIBS+=  -lc   -lpthread -lz  -lm -no-pie  
OBJS= $(SRCS:.c=.o)
CC=gcc
TARGET=x86
all:  adb_$(TARGET)

#CC=arm-linux-gnueabihf-gcc
#CC=aarch64-linux-gnu-gcc
#CC=gcc


adb_$(TARGET): $(OBJS) libcrypto_$(TARGET).a
	$(CC) -o $@ $(LDFLAGS) $(OBJS) $(LIBS) $(CPPFLAGS) $(LIBS)  -Wl,-Bstatic -lcrypto_$(TARGET) -lstdc++  -Wl,-Bdynamic -std=c++1z
	@rm  $(filter %.o,$(OBJS)) 
clean:
	rm  adb_*