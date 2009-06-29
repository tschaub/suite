Description of svn contents:

buildscripts - Contains paver + NSIS scripts required to download all artifacts
medford - Styles for medford data/demo
opengeosphinxtheme - Sphinx theme that is branded to look like OpenGeo
README.txt - This.


Instructions:

   * In the buildscripts directory, run the command

       paver build_all

     (requires python/paver)

   * In the buildscripts/installer, run OpenGeoInstaller.nsi

     (requires makensis)

This should output an .EXE file.  Voilà.