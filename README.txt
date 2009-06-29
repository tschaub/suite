Description of svn contents:

buildscripts
   - Contains paver + NSIS scripts required to download all artifacts

installerdocs
   - Documentation source for installation full Suite installation.
     Requires Sphinx.

integrationdocs
   - Documentation source for full Suite. Requires Sphinx.

medford
   - Styles for Medford data/demo

opengeosphinxtheme
   - Sphinx theme that is branded to look like OpenGeo.

README.txt
   - This document.


Instructions:

   * In the buildscripts directory, run the command

       paver build_all

     (requires python/paver)

   * In the buildscripts/installer, run OpenGeoInstaller.nsi

     (requires makensis)

This should output an .EXE file.  Voila.