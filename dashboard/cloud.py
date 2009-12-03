#!/usr/bin/env python
#
# This script is used to package a Titanium application in the cloud.
#

import sys, os, logging, urllib, urllib2, json, zipfile, StringIO

logger = logging.getLogger("cloud")
cloud_url = "https://api.appcelerator.net/p/v1/"

def login(app_path, user, password):

    url = cloud_url + "sso-login"

    # get some app details
    h = open(os.path.join(app_path, "timanifest"))
    manifest = json.loads(h.read())
    h.close()

    data = urllib.urlencode({"mid": manifest["mid"], "un": user, "pw": password})
    h = urllib.urlopen(url, data)
    response = h.read()
    h.close()
    
    details = json.loads(response)
    if not details["success"]:
        logger.warning("login failed: %s", response)

    return details


def bundle(app_path, ignore=(".svn",)):

    def add_entry(path, archive):
        if os.path.isdir(path):
            for entry in [e for e in os.listdir(path) if e not in ignore]:
                entry = os.path.join(path, entry)
                add_entry(entry, archive)
        elif path not in ignore:
            archive.write(path, path[len(app_path)+1:])
        return
    
    entries = ("Resources", "modules", "timanifest", "manifest",
               "tiapp.xml", "CHANGELOG.txt", "LICENSE.txt")

    zip_data = StringIO.StringIO()
    archive = zipfile.ZipFile(zip_data, "w", zipfile.ZIP_DEFLATED)    
    for entry in entries:
        path = os.path.join(app_path, entry)
        if os.path.exists(path):
            add_entry(path, archive)
    archive.close()

    zip_data.seek(0)
    return zip_data


def package(zip_data, sid=None, token=None, uid=None, uidt=None):

    url = cloud_url + "publish"
    params = urllib.urlencode({
        "sid": sid,
        "token": token,
        "uid": uid,
        "uidt": uidt
    })
    data = zip_data.read()
    headers = {
        "Content-Type": "application/zip", 
        "Content-Length": str(len(data))
    }
    
    req = urllib2.Request("%s?%s" % (url, params), data, headers)
    h = urllib2.urlopen(req)
    response = h.read()
    h.close()
    
    details = json.loads(response)
    if not details["success"]:
        logger.warning("packaging failed: %s", response)
    
    return details["ticket"]


def check_status(ticket):
    
    url = cloud_url + "publish-status"
    params = urllib.urlencode({"ticket": ticket})
    h = urllib.urlopen("%s?%s", (url, params))
    response = h.read()
    h.close()

    details = json.loads(response)
    if details["success"] == False:
        logger.warning("packaging failed: %s", response)
    
    if details["status"] == "complete":
        # deal with success
        pass
    elif details["success"] == False:
        # deal with failure
        pass
    else:
        # keep waiting (check_status again later)
        pass


def main():

    from optparse import OptionParser, OptionGroup

    # configure the command line parser
    parser = OptionParser(
        usage="usage: %prog [options] app_path",
        description="Build a Titanium app in the cloud."
    )
    parser.add_option(
        "-u", "--user",
        help="USER with permission to build the app (PASSWORD must be supplied as well)"
    )
    parser.add_option(
        "-p", "--password",
        help="PASSWORD for the USER"
    )
    parser.add_option(
        "-v", "--verbose",
        help="print all messages"
    )
    
    group = OptionGroup(
        parser, "Non-login options", 
        "Provide these options if USER and PASSWORD are not supplied."
    )
    group.add_option("--sid")
    group.add_option("--token")
    group.add_option("--uid")
    group.add_option("--uidt")
    parser.add_option_group(group)

    (options, args) = parser.parse_args()
    
    if not len(args) == 1:
        parser.error("You must provide the path to your application.  Run with -h for help.")

    # add handler for console to logger
    logger = logging.getLogger("cloud")
    console_handler = logging.StreamHandler()
    if options.verbose:
        console_handler.setLevel(logging.DEBUG)
    else:
        console_handler.setLevel(logging.ERROR)
    formatter = logging.Formatter("%(asctime)s - %(name)s - %(levelname)s - %(message)s")
    console_handler.setFormatter(formatter)
    logger.addHandler(console_handler)
    
    # gather app details
    details = {}
    if options.user and options.password:
        details = login(app_path, user, password)
    else:
        if not (options.sid and options.token and options.uid and options.uidt):
            parser.error("You must provide either USER and PASSWORD or all of SID, TOKEN, UID, and UIDT. Run with -h for help.")

        details["sid"] = options.sid
        details["token"] = options.token
        details["uid"] = options.uid
        details["uidt"] = options.uidt
    
    # bundle up app resources as a zip
    zip_data = bundle(app_path)
    
    # post app bundle for packaging
    ticket = package(zip_data, sid=details['sid'], token=details['token'], uid=details['uid'], uidt=details['uidt'])
    
    # keep checking status until complete

if __name__ == "__main__":
    main()
