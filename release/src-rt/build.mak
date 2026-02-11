build_all:
	@echo ""
	@echo "Building FreshTomato $(branch_rev) $(current_BUILD_USB) $(current_TOMATO_VER)$(beta)$(current_V2) $(current_BUILD_DESC) $(current_BUILD_NAME) with $(TOMATO_PROFILE_NAME) Profile"
	@echo ""
	@echo ""

	@-mkdir image
	@$(MAKE) -C router all
	@$(MAKE) -C router install
	@$(MAKE) -C btools

	@echo "\033[41;1m   Creating image \033[0m\033]2;Creating image\007"

	@rm -f image/freshtomato-$(branch_rev)$(fn_BUILD_USB)$(fn_NVRAM_SIZE)-$(current_TOMATO_VER)$(beta)$(current_V2)-$(current_BUILD_DESC).trx
	@rm -f image/freshtomato-$(branch_rev)$(fn_BUILD_USB)$(fn_NVRAM_SIZE)-$(current_TOMATO_VER)$(beta)$(current_V2)-$(current_BUILD_DESC).bin

ifeq ($(LINKSYS_E),y)
	@rm -f image/freshtomato-E??00$(fn_BUILD_USB)$(fn_NVRAM_SIZE)-$(branch_rev)-$(current_TOMATO_VER)$(beta)$(current_V2)-$(current_BUILD_DESC).bin
endif
ifeq ($(BELKIN),y)
 ifneq ($(NVRAM_SIZE),60)
	@rm -f image/freshtomato-F7D????-$(branch_rev)$(fn_BUILD_USB)-$(current_TOMATO_VER)$(beta)$(current_V2)-$(current_BUILD_DESC).bin
	@rm -f image/freshtomato-F5D8235v3-$(branch_rev)$(fn_BUILD_USB)-$(current_TOMATO_VER)$(beta)$(current_V2)-$(current_BUILD_DESC).bin
 endif
endif

ifeq ($(wildcard include/bcm20xx.h),)
	$(call CREATE_INJECT_MODEL_LINKSYS,freshtomato-WRT54G_WRT54GL-$(branch_rev)$(fn_BUILD_USB)-$(current_TOMATO_VER)$(beta)$(current_V2)-$(current_BUILD_DESC).bin,-l,W54G)
	$(call CREATE_INJECT_MODEL_LINKSYS,freshtomato-WRT54GS-$(branch_rev)$(fn_BUILD_USB)-$(current_TOMATO_VER)$(beta)$(current_V2)-$(current_BUILD_DESC).bin,-l,W54S)
	$(call CREATE_INJECT_MODEL_LINKSYS,freshtomato-WRT54GSv4-$(branch_rev)$(fn_BUILD_USB)-$(current_TOMATO_VER)$(beta)$(current_V2)-$(current_BUILD_DESC).bin,-l,W54s)
	$(call CREATE_INJECT_MODEL_LINKSYS,freshtomato-WRTSL54GS-$(branch_rev)$(fn_BUILD_USB)-$(current_TOMATO_VER)$(beta)$(current_V2)-$(current_BUILD_DESC).bin,-l,W54U)
	$(call CREATE_INJECT_MODEL_LINKSYS,freshtomato-WR850G-$(branch_rev)$(fn_BUILD_USB)-$(current_TOMATO_VER)$(beta)$(current_V2)-$(current_BUILD_DESC).bin,-m,0x10577050)
else
 ifeq ($(LINKSYS_E),y)
	# Linksys E-series build
	$(call CREATE_INJECT_MODEL_LINKSYS,freshtomato-E4200-$(branch_rev)$(fn_BUILD_USB)$(fn_NVRAM_SIZE)-$(current_TOMATO_VER)$(beta)$(current_V2)-$(current_BUILD_DESC).bin,-l,4200)
	$(call CREATE_INJECT_MODEL_LINKSYS,freshtomato-E3000-$(branch_rev)$(fn_BUILD_USB)$(fn_NVRAM_SIZE)-$(current_TOMATO_VER)$(beta)$(current_V2)-$(current_BUILD_DESC).bin,-l,61XN)
	$(call CREATE_INJECT_MODEL_LINKSYS,freshtomato-E2000-$(branch_rev)$(fn_BUILD_USB)$(fn_NVRAM_SIZE)-$(current_TOMATO_VER)$(beta)$(current_V2)-$(current_BUILD_DESC).bin,-l,32XN)
 else
  ifeq ($(BELKIN),y)
   ifneq ($(NVRAM_SIZE),60)
	# Create Belkin F7D3301, F7D3302, F7D4302, F5D8235v3 images
	$(call CREATE_INJECT_MODEL_BELKIN,freshtomato-F7D3301-$(branch_rev)$(fn_BUILD_USB)-$(current_TOMATO_VER)$(beta)$(current_V2)-$(current_BUILD_DESC).bin,0x20100322)
	$(call CREATE_INJECT_MODEL_BELKIN,freshtomato-F7D3302-$(branch_rev)$(fn_BUILD_USB)-$(current_TOMATO_VER)$(beta)$(current_V2)-$(current_BUILD_DESC).bin,0x20090928)
	$(call CREATE_INJECT_MODEL_BELKIN,freshtomato-F7D4302-$(branch_rev)$(fn_BUILD_USB)-$(current_TOMATO_VER)$(beta)$(current_V2)-$(current_BUILD_DESC).bin,0x20091006)
	$(call CREATE_INJECT_MODEL_BELKIN,freshtomato-F5D8235v3-$(branch_rev)$(fn_BUILD_USB)-$(current_TOMATO_VER)$(beta)$(current_V2)-$(current_BUILD_DESC).bin,0x00017116)
   endif
  else
	@echo "Creating Generic TRX Firmware (RT)"
	$(call CREATE_INJECT_MODEL_GEN,freshtomato$(current_BUILD_FN)-$(branch_rev)$(fn_BUILD_USB)$(fn_NVRAM_SIZE)-$(current_TOMATO_VER)$(beta)$(current_V2)-$(current_BUILD_DESC).trx)
  endif
 endif
endif
