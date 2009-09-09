from __future__ import with_statement

from paver.easy import *
from paver.setuputils import setup
import ConfigParser
from paver.easy import path, sh, info, pushd
from paver.easy import task 
from paver import svn 
import os, zipfile 
from  shutil import copytree,rmtree , copy, rmtree
import urlgrabber.grabber
from urlgrabber.grabber import urlgrab
from urlgrabber.progress import text_progress_meter
import string
import sys

#http://user:pass@foo.org/bar

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
This is how mike wants source to look 
===================================== 
installer\
geoserver\
geoserver_plugins\[plugins]\  -> right now this is messed up 
geoexplorer\
geoserver_docs\
geoexplorer_docs\
integration_docs\
sun-java.exe

'''



builder = path("builder")
if not builder.exists(): 
    os.mkdir(builder)

#@@ use auto and options rather than module globals
config = ConfigParser.RawConfigParser()
config.read("config.ini")
download_path = path(config.get("files","downloads")) 
docs_path = path("documentation")
geoserverURL=path(config.get("urls","sourceforgeGS"))
plugin_path = path("geoserver_plugins")
source_path = path(config.get("files","source"))


def unzip_file(file):     
    zip = zipfile.ZipFile(file)
    for zipFile in zip.namelist(): 
        info(zipFile)

        if zipFile.endswith('/'): 
            os.mkdir(zipFile)
        else: 
            outfile = open(zipFile, 'wb')
            outfile.write(zip.read(zipFile))
            outfile.close()



@task
@needs(["setuptools.develop"])
def develop(): 
    pass 

@task 
def auto(): 
    pass 


@task 
def dir_layout(): 
    info("Build Installer Layout")
    for _dir in config.options("files"): 
        _dir=path(config.get("files",_dir))
        if not _dir.exists(): 
            os.mkdir(_dir)

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

def url_with_basic_auth(url, authstr):
    auth = dict()
    auth['user'], auth['password'] = authstr.split(':')
    return string.Template(url).substitute(auth)

@task 
@needs(["dir_layout"])
@cmdopts([
    ('auth=', 'a', 'username:password')
])
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
                version = config.get("version","geoserver")
                if url.startswith("http://$user:$password@"):
                    if not options.download_bin.auth:
                        info("%s requires you set -a user:pw to download" %url)
                        sys.exit()
                    url = url_with_basic_auth(url, options.download_bin.auth)
                urlgrab(url,'geoserver.zip',progress_obj=text_progress_meter())

@task
def unpack_geoserver(): 
    version = config.get("version","geoserver")
    geoserver_vs = path('geoserver-2.0-SNAPSHOT')    
    geoserver = path("geoserver")
    geoserverZIP = "geoserver.zip" 
    geoserverSRC = path.joinpath(download_path,geoserverZIP)
    info("Moving GeoServer into %s" % source_path)
    copy(geoserverSRC,source_path)
    with pushd(source_path):
        if geoserver_vs.exists():
            rmtree(geoserver_vs)
        if geoserver.exists():
            rmtree(geoserver)
        unzip_file(geoserverZIP)
        os.rename(geoserver_vs,geoserver)
        os.remove(geoserverZIP)

@task
def unpack_java(): 
    java = path("jre")
    javaZIP = "jre.zip" 
    javaSRC = path.joinpath(download_path,javaZIP)
    info("Moving JRE into %s" % source_path)
    copy(javaSRC,source_path)
    with pushd(source_path):
        if java.exists():
            rmtree(java)
        os.mkdir(java) # I wonder why this was necessary
        unzip_file(javaZIP)
        os.remove(javaZIP)


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
            svn.checkout(url,software)

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
'''
    def move(): 
        ge_final = path.joinpath(source_path,path("geoexplorer"))
        if ge_final.exists():
            # hack to get around windows not playing well with svn. 
            # i hope to fix this 
            if sys.platform == 'win32': 
                sh("rd /S /Q %s" % ge_final ) 
            else:
                rmtree(ge_final)
        os.mkdir(ge_final)
        copy(path.joinpath(geoexplorer_path,'debug.html'),ge_final)
        copy(path.joinpath(geoexplorer_path,'embed.html'),ge_final)
        copy(path.joinpath(geoexplorer_path,'license.txt'),ge_final)
        copy(path.joinpath(geoexplorer_path,'about.html'),ge_final)
        copytree(path.joinpath(geoexplorer_path,'lib'),path.joinpath(ge_final,'lib'))
        copytree(path.joinpath(geoexplorer_path,'script'),path.joinpath(ge_final,'script'))
        copytree(path.joinpath(geoexplorer_path,'externals'),path.joinpath(ge_final,'externals'))
        copytree(path.joinpath(geoexplorer_path,'theme'),path.joinpath(ge_final,'theme'))        
    move()
'''
@task
def geoserver_plugins(): 
    '''
    Downloads GeoServer Plug-ins, see config file for a list of
    plugins being downloaded. 

    '''
    def download():
        with pushd(download_path):
            if not plugin_path.exists(): 
                os.mkdir(plugin_path) 
            with pushd(plugin_path):                
                section = "geoserver_plugins_urls"
                for plugin in config.options(section): 
                    info("Downloading GeoServer2.0 Plugins %s" % plugin)
                    plugin = config.get(section,plugin)
                    version = config.get("version","geoserver")
                    info("download geoserver plugins")
                    pluginURL = "%s%s-%s" % (geoserverURL,version,plugin)
                    info(pluginURL)
                    pluginZIP = "%s-%s" % (version,plugin)
# This is broken, needs fixing Jul 14 
#                    urlgrab(pluginURL,pluginZIP,progress_obj=text_progress_meter())
#                   unzip_file(pluginZIP)
    def move():
        info("Moving GeoServer Plugins")
        dest = path.joinpath(source_path,path("geoserver_plugins"))
        src = path.joinpath(download_path,plugin_path)
        copytree(src,dest) 

    download()
    move()


@task 
def download_docs(): 
    '''
    This downloads the OpenGeo Documentation
    '''
    with pushd(download_path) as download:
        if not docs_path.exists(): 
            os.mkdir(docs_path)
        with pushd(docs_path):
            section = "docs" 
            for doc in config.options(section): 
                info("Download Docs for %s" % doc) 
                url = config.get(section,doc) 
                svn.checkout(url,doc)
    

@task 
@needs(['download_docs'])
def docs():
    ''' 
    This builds the OpenGeo Documentation
    ''' 
    section = "docs" 
    def build():
        # fix 
        with pushd(download_path):
            with pushd(docs_path):
                svn.checkout('http://svn.codehaus.org/geoserver/trunk/doc/en/theme/','theme')
                svn.checkout('http://svn.opengeo.org/vulcan/trunk/docs/opengeotheme/','opengeotheme')
                for doc in config.options(section): 
                    info("Build docs for %s" % doc) 
                    app_doc = path(doc)
                    with pushd(app_doc):
                        if doc == 'geoexplorer':                             
                            sh("sphinx-build -bhtml . html")
                        else:
                            sh("sphinx-build -bhtml source html")

    def move(): 
        for doc in config.options(section): 
            doc_path = path.joinpath(download_path,docs_path,doc,path('html'))
            copytree(doc_path,path.joinpath(source_path,path("%s_doc"% doc)))            
    build()
    move()

@task
def source_dirs(): 
    '''
    Right now this only makes a integration_docs folder in the source dir
    This is a sub as we need to download the source these docs. To be done 
    
    '''
    interDocs = path.joinpath(source_path,path('integration_docs'))
    if not interDocs.exists():
        os.mkdir(interDocs)

@task
@needs(["dir_layout"])
def data_dir(): 
    '''
    Download a zip file and moved into the GeoServer folder.
    '''
    vulcan_datadir = 'vulcan_datadir.zip'
    with pushd(download_path):
        if path('data.zip').exists():
            os.remove('data.zip')
            rmtree('data')
        urlgrab('http://data.opengeo.org/vulcan/vulcan_datadir.zip',vulcan_datadir,progress_obj=text_progress_meter())
        unzip_file(vulcan_datadir)
    info("moved data_dir into %s" % source_path)
    if path.joinpath(source_path,'data_dir').exists():
        rmtree(path.joinpath(source_path,'data_dir'))
    copytree(path.joinpath(download_path,'data'),path.joinpath(source_path,'data_dir'))

@task 
def styler(): 
    ''' 
    This downloads the Styler 
    ''' 
    styler_download = path.joinpath(download_path,'styler')
    styler_source = path.joinpath(source_path,'styler')
    with pushd(download_path):
        svn.checkout('http://svn.opengeo.org/geoext/apps/styler2/trunk/','styler')
        with pushd(path('styler')):
            sh('jsbuild   build.cfg')
    if not styler_source.exists():
        os.mkdir(styler_source)
    copy(path.joinpath(styler_download,'index.html'),styler_source)
    copytree(path.joinpath(styler_download,'script'),path.joinpath(styler_source,'script'))
    copytree(path.joinpath(styler_download,'theme'),path.joinpath(styler_source,'theme'))
    copytree(path.joinpath(styler_download,'externals'),path.joinpath(styler_source,'externals'))
                       
@task 
def cleanup(): 
    ''' 
    Cleans up download folder after the script is down 
    ''' 
    rmtree(download_path)

@task
def download_all(): 
    info("Download OpenGeo Suite plus dependencies")
    call_task("dir_layout")
    call_task("download_bin")
    call_task("download_source")
    call_task("geoserver_plugins")
    

@task
@needs(["dir_layout","download_bin"])
def build_all(): 
    info("Building all of the OpenGeo Stack")
    call_task("download_source")
    call_task("unpack_java")
    call_task("gx")
    call_task("unpack_geoserver")
    call_task("data_dir")
    call_task("styler")
    call_task("download_docs")
    call_task("docs")
'''
    try:
        call_task("cleanup")
    except Exception, e:
        info(e)
'''


