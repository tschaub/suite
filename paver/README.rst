

Full Stack Installer
==================== 

This is a paver script for gathering the different parts of the
opengeo suite. You will need to install paver to run this script:: 
  
   easy_install paver  


It is also suggested that you use a virtual environment as to not mess
your system wide python install. 



Tasks
---------------

 A. Initialize
   -> Build Dir layout 
      * downloads, software, data 
   -> Check Java version
   -> If Java is not installed, install Java and configure 
   -> Since we are using GS2 we can use the JRE

 B. GeoServer2.0
    -> Base install of GeoServer. Windows + binary. 
    -> Different plug-ins for GeoServer 
    -> Script should install the plug-ins and check to make sure they installed 
         -> ArcSDE -> Needs to download .jars from ESRI site 
	 -> Styler -> Technically this is an GeoExt application --> needs REST... SVN -> 
	 -> GeoSearch ? 

 C.  Download data 
     -> We need to download a data set and configure GS to use that data. 
     -> Data will be Medford and maybe SF data set


 D. OpenLayers  
    -> Base install of OpenLayers (Trunk) 
    -> jstools to compress OpenLayers 
    -> Script should run jstools 

 E. GeoExt
    -> Download and install GeoExt Applications 
    -> GeoBuilder @task -> make sure 


 F. Final steps 
     -> Use NSIS scripts to build installer. 
        * Check to see if system is windows or Linux. --> Mac will not work. 





Basic Dependencies
------------------ 

Python 
------- 
   JSTools
   OWSLib 
   

Apt-get packages 
----------------- 
   NSIS 


Java
----- 
    JRE 

GeoServer plug-ins
------------------ 
     ArcSDE .jars


