

Full Stack Installer
==================== 

This is a paver script for gathering the different parts of the
opengeo suite. You will need to install paver to run this script:: 
  
Install deps
------------ 

#. non-python deps 

   ant

#. python deps 

   virtualenv Vulcan
	
#. Setup and download vulcan.
   mkdir Vulcan/src 
   cd Vulcan/
   . bin/activate
   cd src 
   svn co http://svn.opengeo.org/vulcan



Tasks 
----- 

 #. ! Replacing the data_dir that's currently in data.opengeo.org and using the one in vulcan trunk
 #. ! Add the dashboard working
 #. ! Verify svn external for sphinx opengeo theme 
 #. ! Adding in styler docs.  (http://svn.opengeo.org/vulcan/trunk/docs/styler/)
 #. ! Get it working.
