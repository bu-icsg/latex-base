# Base LaTeX Build Environment

This is a bare-bones environment for building LaTeX documents and
presentations driven by `latexmk`.

## Directory Structure

  * `build` -- Main build directory where all output files will be
    written
  * `scripts` -- Defines certain helper build scripts
  * `src` -- Top-level repository for all source LaTeX files
    * `bib` -- Directory containing all BibTeX files
    * `figures` -- Directory containing all figures
    * `templates` -- Directory for LaTeX templates
  * `submodules` -- Other git repositories that are used by this repo
    * `palette-art` -- Submodule that defines Colorbrewer colors for
      use in LaTeX
