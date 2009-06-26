from __future__ import with_statement

from paver.easy import *
from paver.setuputils import setup
import ConfigParser
from paver.easy import path, sh, info, pushd
from paver.easy import task 
from paver import svn 
import os, zipfile 
import shutil

setup(
    name="builder",
    packages=['builder'],
    version=".1",
    url="http://opengeo.org",
    author="Ivan Willig",
    author_email="iwillig@opengeo.org",
    install_requires=[
        "JSTools>=0.1.2",
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
        if zipFile.endswith('/'): 
            os.mkdir(zipFile)
        else: 
            outfile = open(zipFile, 'wb')
            outfile.write(zip.read(zipFile))
            outfile.close()



@task
#@needs(["setuptools.develop"])
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
def clean_dir(): 
    info("Cleaning Installer Layout") 
    for _dir in config.options("files"): 
        _dir=path(config.get("files",_dir))
        if _dir.exists():
            shutil.rmtree(_dir)
    

@task 
@needs(["dir_layout"])
def download_bin(): 
    '''
    Downloads the binary files
    '''
    with pushd(download_path) as download: 
        section = "bin_software"
        for software in config.options(section):            
            info("Downloading %s" % software)
            url = config.get(section,software)
            if software == 'java': 
                # This is a hack, the Java download was a pain in the ass 
                # I need to add an .exe to the end of the file 
                info("We are downloading Java and it sucks.")
                sh("curl -o sun-java.exe \"%s\" " % url) 
            if software == 'geoserver':
                version = config.get("version","geoserver")
                sh("curl -O %s%s-bin.zip" % (geoserverURL,version))
            else: 
                pass

@task
def unpack_geoserver(): 
    version = config.get("version","geoserver")
    geoserver_vs = path(version)
    geoserver = path("geoserver")
    geoserverZIP = "%s-bin.zip" % version
    geoserverSRC = path.joinpath(download_path,geoserverZIP)
    info("Moving GeoServer into %s" % source_path)
    shutil.copy(geoserverSRC,source_path)
    with pushd(source_path):
        if geoserver_vs.exists():
            shutil.rmtree(geoserver_vs)
        if geoserver.exists():
            shutil.rmtree(geoserver)
        unzip_file(geoserverZIP)
        os.rename(geoserver_vs,geoserver)
        os.remove(geoserverZIP)

@task
def move_java(): 
    java_path = path.joinpath(download_path,'sun-java.exe')
    shutil.copy(java_path,source_path)


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
    gx_build = path('GeoExplorer.js')
    def build_min():
        sh("jsbuild %s  geoexplorer-all.cfg" % gx_build) 
    with pushd(geoexplorer_build): 
        if gx_build.exists(): 
            os.remove(gx_build)
        build_min() 
    shutil.copy(path.joinpath(geoexplorer_build,gx_build),path.joinpath(geoexplorer_path,'script'))
    def move(): 
        ''' 
        Move all of the GeoExplorer file into a folder in source ... 
        ''' 
        ge_final = path.joinpath(source_path,path("geoexplorer"))
        if ge_final.exists():
            # hack to get around windows not playing well with svn. 
            # i hope to fix this 
            if sys.platform == 'win32': 
                sh("rd /S /Q %s" % ge_final ) 
            else:
                shutil.rmtree(ge_final)
        os.mkdir(ge_final)
        shutil.copy(path.joinpath(geoexplorer_path,'index.html'),ge_final)
        shutil.copy(path.joinpath(geoexplorer_path,'embed.html'),ge_final)
        shutil.copy(path.joinpath(geoexplorer_path,'license.txt'),ge_final)
        shutil.copy(path.joinpath(geoexplorer_path,'about.html'),ge_final)
        shutil.copytree(path.joinpath(geoexplorer_path,'script'),path.joinpath(ge_final,'script'))
        shutil.copytree(path.joinpath(geoexplorer_path,'externals'),path.joinpath(ge_final,'externals'))
        shutil.copytree(path.joinpath(geoexplorer_path,'theme'),path.joinpath(ge_final,'theme'))        
    move()

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
                    sh("curl -O %s%s-%s" % (geoserverURL,version,plugin))
                    pluginZIP = "%s-%s" % (version,plugin)
                    unzip_file(pluginZIP)
    def move():
        info("Moving GeoServer Plugins")
        dest = path.joinpath(source_path,path("geoserver_plugins"))
        src = path.joinpath(download_path,plugin_path)
        shutil.copytree(src,dest) 

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
def docs():
    ''' 
    This builds the OpenGeo Documentation
    ''' 
    section = "docs" 
    def build():
        with pushd(download_path):
            with pushd(docs_path):
                for doc in config.options(section): 
                    info("Build docs for %s" % doc) 
                    app_doc = path(doc)
                    with pushd(app_doc):
                        if doc == 'geoext':                             
                            sh("sphinx-build -bhtml . html")
                        else: 
                            sh("sphinx-build -bhtml source html")
    def move(): 
        for doc in config.options(section): 
            doc_path = path.joinpath(download_path,docs_path,doc,path('html'))
            shutil.copytree(doc_path,path.joinpath(source_path,path("%s_doc"% doc)))            
    build()
    move()

@task
def source_dirs(): 
    '''
    Right now this only makes a integration_docs folder in the source dir
    This is a sub as we need to download the source these docs. To be done 
    
    '''
    interDocs = path.joinpath(source_path,path('integration_docs'))
    if not interDocs.exitis():
        os.mkdir(interDocs)

@task
@needs(["dir_layout"])
def data_dir(): 
    '''
    This download the data from GeoServer? Maybe 
    and downloads the styles from the rest API
    '''
    data_dir = path("data_dir")
    styles_path =  path.joinpath(data_dir,path("medford"))
    gs_url = "http://localhost:8080/geoserver/"
    url = "http://svn.opengeo.org/vulcan/trunk/medford/"
    def styles(url):
        with pushd(data_dir): 
            svn.checkout(url,'medford')
    def data(): 
        info("Uploading all styles")
        slds = styles_path.files("*.sld")
        for sld in slds:
            name = sld.strip("data_dir/medford/")
            sh("""
               curl -u admin:geoserver -XPUT -H 'Content-type: application/vnd.ogc.sld+xml' -d @ %s http://localhost:8080/geoserver/rest/styles/%s                    
                  """ % (sld,name))

#   styles(url)
    data()



@task
def download_all(): 
    info("Download OpenGeo Suite plus dependencies")
    call_task("dir_layout")
    call_task("download_bin")
    call_task("download_source")
    call_task("geoserver_plugins")
    

@task 
def build_all(): 
    info("Building all of the OpenGeo Stack")
    call_task("dir_layout")
    call_task("download_bin")
    call_task("source_dirs")
    call_task("download_source")
    call_task("move_java")
    call_task("gx")
    call_task("unpack_geoserver")
    call_task("geoserver_plugins")
    call_task("download_docs")
    call_task("docs")



