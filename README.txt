Description of svn contents:

buildscripts
   - Contains scripts required to download all required artifacts
   - Requires paver (python) + NSIS

docs

   - installerdocs
      - Documentation source for installation full Suite installation
      - Requires Sphinx.

   - integrationdocs
      - Documentation source for full Suite aka "Getting Started"
      - Requires Sphinx.

   - opengeotheme
     - Sphinx theme that is branded to look like OpenGeo.
       (Common to both of the above projects) 

medford
   - Styles for Medford data/demo

geoserver
   - Custom modules and custom webapp overlay for Vulcan

README.txt
   - This document.



Build the OpenGeo Suite installer:

   * In the buildscripts directory, run the command

        paver build_all

   * In the buildscripts\artifacts\installer directory, run

        makensis OpenGeoInstaller.nsi (for CLI build)
     or
        makensisw OpenGeoInstaller.nsi (for GUI build)


This should output an .EXE file.
