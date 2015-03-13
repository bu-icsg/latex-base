# Base LaTeX Build Environment

This is a bare-bones environment for building LaTeX documents and
presentations driven by `latexmk` and loosely based on Chris Batten's
Automatic LaTeX Build System (but slightly less full featured and not
using Chris' custom Ruby dependency chaser).

## Setup and Usage

Edit `CONFIG.m4` changing the defines to point to the names of your
top-level paper and presentation, e.g., `mypaper.tex` and
`mypresentation.tex` which live in the `src` directory. You can then
get everything setup with the "not really a `configure` script":

```bash
./configure
```

This will populate a template Makefile with your defined
paper/presentation. You can then just use `make`:

```bash
make
```

Note that by default, I have enabled the `format-build` target. This
feeds all input files in the `src` directory that look like
`^.*?sec-.+?\.tex` (things like `sec-introduction.tex`) through Andrew
Stacey's `fmtlatex`. This forcibly rewrites all input files into a
one-sentence-per-line format. This format is __strongly preferable__
when version controlling LaTeX files and helps avoid a one word
modification from turning into a complete paragraph rewrite due to
compulsive paragraphing reflow habits, e.g., `emacs` `M-q` tic. I have
yet to encounter this breaking anything, but it is possible. All files are first backed up in `src/bak`.

## Directory Structure

* `build` -- Main build directory where all output files will be
    written
* `scripts` -- Defines certain helper build scripts, like `fmtlatex`
* `src` -- Top-level repository for all source LaTeX files. Section files are expected to look like `sec-XXX.tex`.
    * `bak` -- Contains the most recent backup of anything fed through `fmtlatex`
    * `bib` -- Directory containing all BibTeX files
    * `figures` -- Directory containing all figures
    * `templates` -- Directory for LaTeX templates
* `submodules` -- Other git repositories that are used by this repo
    * `palette-art` -- Submodule that defines Colorbrewer colors for
      use in LaTeX
