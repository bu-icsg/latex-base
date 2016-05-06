.PHONY: all

UNAME_S 	:= $(shell uname -s )

ifeq ($(UNAME_S),Darwin)
	target 	:= mac_view
else
	target 	:= linux_view
endif

view: $(target)

mac_view:
	open -a Preview ../build/latex-base.pdf &
linux_view:
	@if which mupdf > /dev/null; then\
		mupdf ../build/latex-base.pdf &\
	else\
		evince ../build/latex-base.pdf &\
	fi
evince:
	evince ../build/latex-base.pdf &

preview:
	open -a Preview ../build/latex-base.pdf &

all:
	make -C ..
