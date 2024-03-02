include ../common.mak

CFLAGS   = -Os -Wall $(EXTRACFLAGS) -fPIC -ffunction-sections -fdata-sections -Wsign-compare
CFLAGS  += -I. -I$(SRCBASE)/include -I$(SRCBASE)/
LDFLAGS  = -fPIC --gc-sections

ifeq ($(TCONFIG_BCMWL6),y)
 CFLAGS += -DTRAFFIC_MGMT
endif

ifeq ($(TOMATO_EXPERIMENTAL),1)
 export CFLAGS += -DDEBUG_LOGMSG
endif

OBJS = shutils.o wl.o wl_linux.o linux_timer.o defaults.o id.o misc.o \
       led.o version.o base64.o files.o strings.o process.o

# RT-N+
ifeq ($(or $(TCONFIG_BLINK),$(TCONFIG_BCMARM)),y)
 OBJS += nvparse.o
endif

ifeq ($(TCONFIG_USB),y)
 OBJS += usb.o \
        $(TOP)/busybox/util-linux/volume_id/linux_swap.o \
        $(TOP)/busybox/util-linux/volume_id/ext.o \
        $(TOP)/busybox/util-linux/volume_id/util2.o \
        $(TOP)/busybox/util-linux/volume_id/fat.o \
        $(TOP)/busybox/util-linux/volume_id/ntfs.o
 ifeq ($(TCONFIG_BCMARM),y)
  OBJS += $(TOP)/busybox/util-linux/volume_id/exfat.o
 endif
 ifeq ($(TCONFIG_HFS),y)
  CFLAGS += -DHFS
  OBJS += $(TOP)/busybox/libbb/hash_md5_sha.o \
          $(TOP)/busybox/libbb/bb_bswap_64.o \
          $(TOP)/busybox/util-linux/volume_id/hfs.o
 endif
endif

ifeq ($(CONFIG_BCMWL5),y)
 OBJS += wlif_utils.o UdpLib.o
endif

all: libshared.so

libshared.so: $(OBJS)
	@echo " [shared] LD $@"
	@$(LD) $(LDFLAGS) -shared -o $@ $^
	$(SIZECHECK)
	$(CPTMP)

install: all
	@echo " [shared] Installing as $(INSTALLDIR)/usr/lib/libshared.so"
	@install -d $(INSTALLDIR)/usr/lib
	@install -m 755 libshared.so $(INSTALLDIR)/usr/lib
	@$(STRIP) $(INSTALLDIR)/usr/lib/libshared.so

clean:
	rm -f *.o *.so
