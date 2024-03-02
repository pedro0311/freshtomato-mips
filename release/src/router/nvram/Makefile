include ../common.mak

CFLAGS  = -Os -Wall $(EXTRACFLAGS) -fPIC -ffunction-sections -fdata-sections -Wsign-compare
#CFLAGS += -g -DDEBUG
CFLAGS  += -I$(TOP)/shared -I$(SRCBASE)/include -I.
LDFLAGS  = -L. -L$(TOP)/shared -lshared -fPIC -Wl,--gc-sections

ifeq ($(STATIC),1)
 CFLAGS += -static
endif

all: libnvram.so nvram

libnvram.so: nvram_linux.o nvram_convert.o
	@echo " [nvram] CC $@"
	@$(CC) $(CFLAGS) -shared -o $@ $^ $(LDFLAGS)

nvram: nvram.o defaults.o libnvram.so
	@echo " [nvram] CC $@"
	@$(CC) $(CFLAGS) -o $@ nvram.o defaults.o $(LDFLAGS) -lnvram
	$(SIZECHECK)
	$(CPTMP)

install: all
	@echo " [nvram] Installing as $(INSTALLDIR)/usr/lib/libnvram.so"
	@install -D libnvram.so $(INSTALLDIR)/usr/lib/libnvram.so
	@$(STRIP) $(INSTALLDIR)/usr/lib/libnvram.so
	@echo " [nvram] Installing as $(INSTALLDIR)/bin/nvram"
	@install -D nvram $(INSTALLDIR)/bin/nvram
	@$(STRIP) $(INSTALLDIR)/bin/nvram
	@chmod 0555 $(INSTALLDIR)/bin/nvram

clean:
	rm -f *.o *.so nvram
