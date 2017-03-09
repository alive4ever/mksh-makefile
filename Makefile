# Makefile for mksh

PREFIX = $(HOME)/local
BINDIR = $(PREFIX)/bin
MANDIR = $(PREFIX)/share/man
SYSCONFDIR = $(PREFIX)/etc
RM = rm -f
all: bin
bin = mksh lksh
bin: $(bin)
source: *.c
headers: *.h
mksh: Build.sh $(source) $(headers)
	sh ./Build.sh

lksh: Build.sh $(source) $(headers)
	sh ./Build.sh -L

strip: bin
	for bin in $(bin); do \
		strip $${bin}; \
	done

install-bin: bin
	[ -d $(BINDIR) ] || mkdir -p $(BINDIR)
	for bin in $(bin) ; do \
		install -m 755 $$bin $(BINDIR); \
	done

doc = mksh.1 lksh.1
install-doc: $(doc)
	[ -d $(MANDIR)/man1 ] || mkdir -p $(MANDIR)/man1
	for doc in $(doc) ; do \
		gzip -c -9 $$doc > $(MANDIR)/man1/$${doc}.gz; \
	done

catman = mksh.cat1 lksh.cat1
install-catman: $(catman)
	[ -d $(MANDIR)/cat1 ] || mkdir -p $(MANDIR)/cat1
	for catman in $(catman) ; do \
		gzip -c -9 $${catman} > $(MANDIR)/cat1/$${catman%cat1}1 ; \
	done

mkshrc = dot.mkshrc
install-mkshrc: $(mkshrc)
	[ -d $(SYSCONFDIR) ] || mkdir -p $(SYSCONFDIR)
	install -m 644 $(mkshrc) $(SYSCONFDIR)

install: strip install-bin install-doc install-mkshrc
check: bin
	./test.sh

uninstall-bin:
	for bin in $(bin); do \
		[ -d $(BINDIR) ] && $(RM) $(BINDIR)/$$bin ; \
	done

uninstall-doc:
	for doc in $(doc) ; do \
		[ -d $(MANDIR)/man1 ] && $(RM) $(MANDIR)/man1/$${doc}.gz ; \
	done

uninstall-catman:
	for catman in $(catman) ; do \
		$(RM) $(MANDIR)/cat1/$${catman%cat1}1 ; \
	done

uninstall-mkshrc:
	[ -d $(SYSCONFDIR) ] && $(RM) $(SYSCONFDIR)/$(mkshrc)

uninstall: uninstall-bin uninstall-doc uninstall-catman uninstall-mkshrc

clean:
	$(RM) $(bin) $(catman)
