# latexmk-driven build flow
#
# Point of Contact: Schuyler Eldridge <schuyler.eldridge@gmail.com>

DIR_BUILD   = build
DIR_SRC     = src
DIR_TEX     = $(DIR_SRC) $(DIR_SRC)/figures
DIR_BIB     = . ../ ../bib build
DIR_SCRIPTS = scripts

SOURCES_TEX = paper.tex presentation.tex
TARGETS     = $(SOURCES_TEX:%.tex=$(DIR_BUILD)/%.pdf)
TARGETS_PS  = $(SOURCES_TEX:%.tex=$(DIR_BUILD)/%.ps)
TARGETS_OPT = $(TARGETS:%.pdf=%-opt.pdf)

SPACE       = $(EMPTY) $(EMPTY)

LATEXMK     = latexmk \
	-pdf \
	-latexoption="--shell-escape -halt-on-error -file-line-error" \
	-bibtex \
	-time \
	-outdir=$(DIR_BUILD)
LATEXMK_PS  = latexmk \
	-ps \
	-latexoption="--shell-escape -halt-on-error -file-line-error" \
	-bibtex \
	-time \
	-outdir=$(DIR_BUILD)
GS_OPT      = gs \
	-sDEVICE=pdfwrite \
	-dNOPAUSE \
	-dBATCH
ENV         = env TEXINPUTS="$(TEXINPUTS)$(subst $(SPACE),:,$(DIR_TEX)):" \
	BIBINPUTS="$(BIBINPUTS)$(subst $(SPACE),:,$(DIR_BIB)):"

vpath %.tex src

.PHONY: all clean format noformat-build ps optimized colorbrewer

# Default target. This should either be set to build all targets with
# LaTeX formatting cleanup (format-build) OR to just build without
# cleanup (noformat-build)
all: noformat-build

# Top-level build target that runs format (cleanup all source files
# into a "nice" format good for version control) before building
format-build: format noformat-build

# Top-level build target that will build all targets without source
# file cleanup
noformat-build: $(TARGETS)

# Top-level build target that generates optimized versions of the
# pdfs using GhostScript.
optimized: $(TARGETS_OPT)

# Source file cleanup using fmtlatex. This looks for all .tex files in
# the source directory (files in subdirectories of src are ignored,
# e.g., figures) and pushes them throgh fmtlatex which will convert
# them to a one sentence per line structure. Backups
# _of_the_most_recent_version_ONLY_ are made with a .bak suffix.
format:
	find src -maxdepth 1 -regex .+\.tex | \
	xargs -I TEX sh -c \
	'cp TEX TEX.bak && $(DIR_SCRIPTS)/fmtlatex -n 2 TEX.bak > TEX'

# Postscript target. This is currently NOT WORKING.
ps: $(TARGETS_PS)

$(DIR_BUILD)/%.pdf:%.tex Makefile
	$(ENV) $(LATEXMK) $<

$(DIR_BUILD)/%.ps:%.tex Makefile
	$(ENV) $(LATEXMK_PS) $<

$(DIR_BUILD)/%-opt.pdf:$(DIR_BUILD)/%.pdf
	$(GS_OPT) -sOutputFile=$@ $<

clean:
	rm -f $(DIR_BUILD)/* \
	*.dpth \
	*.pdf \
	*.log \
	*.vrb \
	*.aux \
	*.fdb_latexmk \
	*.dep \
	*.fls
