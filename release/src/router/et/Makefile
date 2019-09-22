#
# Makefile ET
#

include ../common.mak

CFLAGS	+= -I. -I$(TOP)/shared -I$(TOP)/busybox -I$(SRCBASE)/include -Wall
CFLAGS	+= -s -Os -DBCMWPA2 -ffunction-sections -fdata-sections
LDFLAGS	+= -L$(TOP)/nvram -L$(INSTALLDIR)/nvram/usr/lib -lnvram -L$(TOP)/shared -L$(INSTALLDIR)/shared/usr/lib -lshared -ffunction-sections -fdata-sections -Wl,--gc-sections

OBJS := et.o

all: et

clean:
	rm -f *.o et .*.depend

install: all
	install -d $(INSTALLDIR)/usr/sbin
	install et $(INSTALLDIR)/usr/sbin
	$(STRIP) $(INSTALLDIR)/usr/sbin/et

et: $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

