# Lazarus project file.
TARGET=marhaba.lpi
EXECUTABLE=marhaba
# Primary config directory, where Lazarus stores its config files.
PCP=/etc/lazarus
# override the project widgetset. e.g. gtk,  gtk2,  qt,  win32  or carbon.
WIDGETSET=gtk2

.PHONY: all build install uninstall clean

all: build

build:
	@echo Start compiling ...
	lazbuild -B --pcp=$(PCP) --ws=$(WIDGETSET) $(TARGET)
	@echo Strip symbols and debug info ...
	@strip $(EXECUTABLE)

	@echo generating locales files ...
	@if [ -f languages/$(EXECUTABLE).po ] ; then mv languages/$(EXECUTABLE).po languages/$(EXECUTABLE).en.po; fi;
	@(cd languages && $(MAKE) build)
	@echo done.
install:
	@echo Creating destination directories ...
	@mkdir -p $(DESTDIR)/usr/bin
	@mkdir -p $(DESTDIR)/usr/share/applications
	@mkdir -p $(DESTDIR)/etc/skel/.config/autostart
	@echo Installing ...
	@cp ./$(EXECUTABLE) $(DESTDIR)/usr/bin/
	@cp -r ./icons $(DESTDIR)/usr/share/
	@cp ./$(EXECUTABLE).desktop $(DESTDIR)/usr/share/applications
	@cp ./$(EXECUTABLE).desktop $(DESTDIR)/etc/skel/.config/autostart
	@cp -r ./languages/locale $(DESTDIR)/usr/share/
	@echo done.

uninstall:
	@echo Uninstalling ...
	@rm -f $(DESTDIR)/etc/skel/.config/autostart/marhaba.desktop
	@rm -f $(DESTDIR)/usr/bin/marhaba
	@rm -f $(DESTDIR)/usr/share/icons/hicolor/32x32/apps/marhaba.png
	@rm -f $(DESTDIR)/usr/share/icons/hicolor/128x128/apps/marhaba.png
	@rm -f $(DESTDIR)/usr/share/icons/hicolor/22x22/apps/marhaba.png
	@rm -f $(DESTDIR)/usr/share/icons/hicolor/48x48/apps/marhaba.png
	@rm -f $(DESTDIR)/usr/share/icons/hicolor/64x64/apps/marhaba.png
	@rm -f $(DESTDIR)/usr/share/icons/hicolor/16x16/apps/marhaba.png
	@rm -f $(DESTDIR)/usr/share/icons/hicolor/scalable/apps/marhaba.svg
	@rm -f $(DESTDIR)/usr/share/locale/en/LC_MESSAGES/marhaba.mo
	@rm -f $(DESTDIR)/usr/share/locale/ar/LC_MESSAGES/marhaba.mo
	@rm -f $(DESTDIR)/usr/share/applications/marhaba.desktop
	@echo Removing empty directories ...
	@if [ -n "${DESTDIR}" ] && [ -d "${DESTDIR}" ]; then \
  	find $(DESTDIR) -type d -empty -delete; \
	fi
	@echo done.
clean:
	@echo Cleaning ...
	@rm -f $(EXECUTABLE)
	@rm -rf lib backup
	@rm -f *.bak
	@rm -f *.lps
	@rm -f *.res
	(cd languages && $(MAKE) clean)
	@if [ -f languages/$(EXECUTABLE).en.po ] ; then mv languages/$(EXECUTABLE).en.po languages/$(EXECUTABLE).po; fi;
	@echo done.
