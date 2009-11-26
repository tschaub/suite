#!/usr/bin/env python
#
# This script is used to package a Titanium application in the cloud.
#

import os.path, urllib, json

app_path = "OpenGeo Dashboard"

# this you have to ask me for
user = "tschaub@opengeo.org"
password = "0p3ng30"

# this is extracted from the Titanium Developer source
login_url = "https://api.appcelerator.net/p/v1/sso-login"

# get some app details
h = open(os.path.join(app_path, "timanifest")
manifest = json.loads(h.read())
h.close()

# log in
login_data = urllib.urlencode({"mid": manifest["mid"], "un": user, "pw": password})
h = urllib.urlopen(login_url, login_data)
login_response = h.read()
h.close()

# assume success (check data["success"] for error handling)
login_data = json.loads(login_response)

# bundle
zip_data = "TODO: bundle resources as zip"

# send package request
package_url = "TODO: determine this"
package_params = urllib.urlencode({
    "sid": login_data["sid"],
    "token": login_data["token"],
    "uid": login_data["uid"],
    "uidt": login_data["uidt"]
})

h = urllib.urlopen("%s?%s" % (package_url, package_params), zip_data)
package_response = h.read()
h.close()

# assume success (check queue_data["success"] for error handling)
queue_data = json.loads(package_response)

# poll packaging progress
def check_status():
    poll_url = "TODO: determine this"
    poll_params = urllib.urlencode({
        "ticket": queue_data["ticket"],
        #"guid": manifest["guid"]  # TODO: determine if this is used
    })
    h = urllib.urlopen(poll_url)
    poll_response = h.read()
    h.close()

    poll_data = json.loads(poll_response)
    
    if poll_data["status"] == "complete":
        # deal with success
        pass
    elif poll_data["success"] == False:
        # deal with failure
        pass
    else:
        # keep waiting (check_status again later)
        pass

# TODO: periodically check packaging status

