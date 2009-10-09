from __future__ import with_statement
# from paver.virtual import bootstrap

from paver.easy import *
from paver.setuputils import setup
import ConfigParser
from paver.easy import path, sh, info, pushd
from paver.easy import task 
from paver import svn 
import os, zipfile 
from os.path import join, isdir
from  shutil import copytree,rmtree , copy, rmtree, move
import urlgrabber.grabber
from urlgrabber.grabber import urlgrab
from urlgrabber.progress import text_progress_meter
import string
import sys


#@@ use auto and options rather than module globals
# Bad Ivan, you must fix this mess
config = ConfigParser.RawConfigParser()
config.read("config.ini")
download_path = path(config.get("files","downloads")) 
docs_path = path("documentation")
source_path = path(config.get("files","source"))
plugin_path = path.joinpath(download_path,"geoserver_plugins") 


builder = path("builder")
if not builder.exists(): 
    os.mkdir(builder)

setup(
    name="builder",
    packages=['builder'],
    version=".1",
    url="http://opengeo.org",
    author="Ivan Willig",
    author_email="iwillig@opengeo.org",
    install_requires=[
        "JSTools>=0.1.2",
        "urlgrabber",
        "Sphinx",
        "OWSLib"], 
    
)

'''
options(
    sphinx=Bunch(
        builddir="_build"
    ),
    virtualenv=Bunch(
        script_name="vulcan_virtualenv",
        packages_to_install=["JSTools>=0.1.2","urlgrabber","Sphinx"],
        paver_command_line="after_envsetup"
    ),

)
'''

'''
Hi Mike, should do break these tasks into two meta sections. 

  1. Download 
    a. Download major software 
    b. Export svn based software
    c. This part of this script leaves everything in state where you
	 can run build with out the net.
 
  2. Build   
    a. Unpacks all zips and non svn software.
    b. Builds all Javascript software with ant and jsbuild. 
    c. Moves everything into $source 

Its important to keep the two task different. One should be able to
	build everything without having to download everything.   

'''


'''
Hi Ivan, that's a very good idea.
'''


@task
@needs(["dir_layout","download_bin"])
def build_all(): 
    info("Building all of the OpenGeo Stack")
    call_task("unpack_java")
    call_task("unpack_geoserver")
    call_task("unpack_datadir")
    call_task("unpack_gdal")
    call_task("download_source")
    call_task("download_plugin")
    call_task("unpack_plugin")
    call_task("gx")
    call_task("styler")
    call_task("download_docs")
    call_task("dashboard")
#    call_task("docs")


@task 
def dir_layout(options): 
    '''
    Creates directory layout
    '''
    info("Build Installer Layout")
    for _dir in config.options("files"): 
        _dir=path(config.get("files",_dir))
        if not _dir.exists(): 
            os.mkdir(_dir)




@task 
@needs(["dir_layout"])
def download_bin(options): 
    '''
    Downloads the binary files

    takes -a --auth username:password
    for geoserver download from hudson
    '''
    with pushd(download_path) as download: 
        section = "bin_software"
        for software in config.options(section):            
            info("Downloading %s" % software)
            url = config.get(section,software)
	    if software == 'java': 
                urlgrab(url,'jre.zip',progress_obj=text_progress_meter())
            if software == 'geoserver':
                urlgrab(url,'geoserver.zip',progress_obj=text_progress_meter())
            if software == 'gdal':
                urlgrab(url,'gdal.zip',progress_obj=text_progress_meter())


@task
def unpack_java(): 
    '''
    Unzips jre.zip into jre
    '''
    java = path("jre")
    javaZIP = "jre.zip" 
    javaSRC = path.joinpath(download_path,javaZIP)
    info("Moving JRE into %s" % source_path)
    copy(javaSRC,source_path)
    with pushd(source_path):
        if java.exists():
            rmtree(java)
        unzip_file(javaZIP)
        os.remove(javaZIP)


@task
def unpack_geoserver(): 
    '''
    Unzips geoserver.zip and copies into artifacts
    '''
    geoserver_vs = path(config.get("version","geoserver"))
    geoserver = path("geoserver")
    geoserverSRC = path.joinpath(download_path,"geoserver.zip")
    info("Moving GeoServer into %s" % source_path)
    copy(geoserverSRC,source_path)
    with pushd(source_path):
        if geoserver_vs.exists():
            rmtree(geoserver_vs)
        if geoserver.exists():
            rmtree(geoserver)
        unzip_file("geoserver.zip")
        os.rename(geoserver_vs,geoserver)
        os.remove("geoserver.zip")







@task
@needs(["dir_layout"])
def unpack_datadir(): 
    '''
    Unzips data_dir.zip into data_dir/
    '''
    base_path =  path(os.getcwd().strip("buildscripts"))    
    vulcan_datadir = path.joinpath(base_path,"data_dir")
    info("Moving data_dir into %s" % source_path)
    copytree(vulcan_datadir,path.joinpath(source_path,"data_dir"))




@task
@needs(["dir_layout"])
def unpack_gdal(): 
    '''
    Unzips gdal.zip into into gdal/ !!!
    '''
 
    gdal_dest_path = path.joinpath(source_path,"gdal")
    info("Moving gdal into %s" % source_path)
    os.mkdir(gdal_dest_path)
    copy(path.joinpath(download_path,'gdal.zip'),gdal_dest_path)
    with pushd(gdal_dest_path):
      unzip_file("gdal.zip")
      os.remove("gdal.zip")



@task 
def download_source(): 
    '''
    Checks out the source code for different OpenGeo Projects
    '''
    with pushd(download_path) as download: 
        section = "svn_software"
        for software in config.options(section): 
            info("Checking out source of %s " % software)
            url = config.get(section,software)
	    sh("svn -q export %s %s" % (url,software))


@task 
def gx(): 
    ''' 
    This builds GeoExplorer and puts in source
    ''' 
    geoexplorer_path = path.joinpath(download_path,path("geoexplorer"))
    geoexplorer_build = path.joinpath(geoexplorer_path,path("build"))
    def build_min():
        sh("ant dist") 
    with pushd(geoexplorer_build): 
        build_min() 
    copytree(path.joinpath(geoexplorer_build,'GeoExplorer'),path.joinpath(path.joinpath(source_path,'GeoExplorer')))



@task 
def styler(): 
    ''' 
    This builds styler 
    ''' 
    base_path =  path(os.getcwd().strip("buildscripts"))    
    styler_path = path.joinpath(base_path,"styler") 
    styler_source = path.joinpath(source_path,"styler")
    script_path = path.joinpath(styler_path,"script")
    if not script_path.exists(): 
     	os.mkdir(script_path)
    with pushd(styler_path):
	sh('jsbuild build.cfg -o script')
    os.mkdir(styler_source)
    copy(path.joinpath(styler_path,'index.html'),styler_source)
    copytree(path.joinpath(styler_path,'script'),path.joinpath(styler_source,'script'))
    copytree(path.joinpath(styler_path,'theme'),path.joinpath(styler_source,'theme'))
    copytree(path.joinpath(styler_path,'externals'),path.joinpath(styler_source,'externals'))




@task 
@needs(["dir_layout"])
def download_docs(): 
    '''
    This downloads the OpenGeo Documentation
    '''
    with pushd(download_path) as download: # go into downloads dir
        if not docs_path.exists():   
            os.mkdir(docs_path)            # make ./documentation
        with pushd(docs_path):
            section = "docs"                   # look in config.ini for [docs]
            for doc in config.options(section):  
                info("Download Docs for %s" % doc) 
                url = config.get(section,doc) 
                sh("svn -q export %s %s" % (url,doc))




@task 
@needs(['download_docs'])
def docs():
    ''' 
    This builds the OpenGeo Documentation
    ''' 
    section = "docs" 
    def build():
        with pushd(path.joinpath(download_path,docs_path)):
        	for doc in config.options(section): 
                	info("Build docs for %s" % doc) 
                	app_doc = path(doc)
                    	with pushd(app_doc):
                        	if doc == 'geoexplorer':                             
                            		sh("sphinx-build -bhtml . html")
				if doc == 'installerdocs':
					print "installer docs" 
				else:
                            		sh("sphinx-build -bhtml source html")

    def move(): 
        for doc in config.options(section): 
            doc_path = path.joinpath(download_path,docs_path,doc,path('html'))
            copytree(doc_path,path.joinpath(source_path,path("%s_doc"% doc)))            
    build()
    move()




def unzip_file(file):     
	zip = zipfile.ZipFile(file)
        for zipFile in zip.namelist():
                if zipFile.endswith('/'):
                        os.mkdir(zipFile)
                else:
                        _dir,file =  os.path.split(zipFile)
                        if _dir and not isdir(_dir):
                                os.makedirs(_dir)
                        outfile = open(zipFile, 'wb')
                        outfile.write(zip.read(zipFile))
                        outfile.close()



@task 
def clean():
    info("Cleaning Installer Layout") 
    for _dir in config.options("files"): 
        _dir=path(config.get("files",_dir))
        if _dir.exists():
            if sys.platform == 'win32': 
                sh("rd /S /Q %s" % _dir )
            else:
                rmtree(_dir)




@task 
def cleanup(): 
    ''' 
    Cleans up download folder after the script is done
    ''' 
    rmtree(download_path)


@task
def download_plugin(options):
    '''
    Downloading GeoServer Plugins 
    ''' 
    plugin_path = path.joinpath(download_path,"geoserver_plugins") 
    if not plugin_path.exists(): 
        os.mkdir(path.joinpath(plugin_path)) 
    with pushd(plugin_path): 
        for plugin in config.options("extensions"):
            base_url = "vulcan.opengeo.org/builds/ext-latest/"
            url = "http://%s%s-%s-plugin.zip" % (base_url,config.get("version","geoserver"),plugin)
            plugin_zip = "%s.zip" % (plugin)
            urlgrab(url,plugin_zip,progress_obj=text_progress_meter())



@task
def unpack_plugin():
    # copy to source 
    des_path = path.joinpath(source_path,"geoserver_plugins")
    if des_path.exists(): 
	rmtree(des_path)
    copytree(plugin_path,path.joinpath(source_path,"geoserver_plugins"))     
    # unzip in source
    with pushd(des_path): 
	for plugin in config.options("extensions"): 
		print "unpacking %s " % plugin
                plugin_zip = "%s.zip" % plugin
                os.mkdir(path(plugin))
		move(plugin_zip,path(plugin))
		with pushd(path(plugin)): 
			unzip_file(plugin_zip)
                        os.remove(plugin_zip)

@task
def dashboard():
    ''' 
    Builds a ti app for the bashboard. you must have the tit env setup 
    linux builds a OpenGeo Suite.tgz file 
    windows builds a OpenGeo Suite.exe file <-- which is really a zip file. 
    ''' 
    
    # build dashboard
    userhome = os.getenv("HOME")
    TIBUILD = "%s/.titanium/" % userhome
    TIENV = "%s/.titanium/sdk/linux/0.6.0/" % userhome
    base_path =  path(os.getcwd().strip("buildscripts"))    
    dash_base = path.joinpath(base_path,"dashboard") 
    dashboard = path.joinpath(dash_base,"OpenGeo Suite")  # will this work? 
    opengeosuite = path.joinpath(dashboard,"OpenGeo\ Suite")
    with pushd(download_path):
        if sys.platform == 'linux2': 
            sh("tibuild.py -v -d ../../buildscripts/%s -n -t bundle  -s %s -a %s ../../dashboard/OpenGeo\ Suite" % (source_path,TIBUILD, TIENV))
        if sys.platform == 'win32': 
            TIBUILD = "C:\\Documents and Settings\\All Users\\Application Data\\Titanium" 
            TIENV  = "C:\\Documents and Settings\\All Users\\Application Data\\Titanium\\sdk\\win32\\0.6.0" 
            sh('tibuild.py -d . -s \"%s\" -a \"%s\" \"..\\..\\dashboard\\OpenGeo Suite\" -n -t bundle' % (TIBUILD, TIENV))
        else: 
            # What do we on OS X ? 
            pass 
        # move finished

    if sys.platform == 'linux2': 
        copy(path.joinpath(dashboard,"OpenGeo Suite.tgz"),source_path)
        with pushd(source_path): 
            sh("gunzip OpenGeo\ Suite.tgz ; tar -xf OpenGeo\ Suite.tar")
            os.remove("OpenGeo Suite.tar")
    if sys.platform == 'win32':
        with pushd(path.joinpath(download_path,"OpenGe~1")): 
            os.rename("OpenGeo Suite.exe","dashboard.zip")
        with pushd(source_path):
            os.mkdir("dashboard")
        with pushd(path.joinpath(source_path,"dashboard")): 
            sh('copy "..\\..\\downloads\\OpenGeo Suite\\dashboard.zip" .')
            unzip_file("dashboard.zip")   # Does not work!  Why not?
            os.remove("dashboard.zip")
            
@task
def source_dirs(): 
    '''
    Right now this only makes a integration_docs folder in the source dir
    This is a sub as we need to download the source these docs. To be done 
    '''
    interDocs = path.joinpath(source_path,path('integration_docs'))
    if not interDocs.exists():
        os.mkdir(interDocs)

                       


