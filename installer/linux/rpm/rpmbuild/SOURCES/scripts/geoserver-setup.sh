#!/bin/bash
# postinst script for geoserver
#

fin=0
myhost=`echo $(/sbin/ifconfig eth0 | awk -F: '/inet addr:/ {print $2}' | awk '{ print $1 }')`
username="admin"
password="admin"
exit=0
set -e

function check_root () {
  if [ ! $( id -u ) -eq 0 ]; then
    printf "This script must be run as root. Exiting.\n"
    exit 1
  fi
}

function randpass() {
  [ "$2" == "0" ] && CHAR="[:alnum:]" || CHAR="[:graph:]"
    cat /dev/urandom | tr -cd "$CHAR" | head -c ${1:-32}
    echo
}

respond() {
  printf "$1: [$2] "
  read choice
  if [  "$choice" = "" ] || [ ${#choice} -lt $3  ]; then
    choice=$2
  fi
}


menu() {

  printf "
  GeoServer Post Configuration.

  Select an entry from the following list:
  ----------------------
  1. Hostname or IP        : $myhost
  2. Admin username        : $username
  3. Admin password        : $password

  9. Accept and continue
  0. Abort and quit

  choice: "

  read menuchoice

case "$menuchoice" in
    "1")
        printf "Please provide the IP address or hostname that GeoServer is accessed\n"
        printf "through publicly. This value is required in cases where GeoServer is\n"
        printf "accessed through an external proxy.\n"
        respond "hostname" "$myhost" "3"
        myhost=$choice
        myhost=`echo $myhost | sed s#http://##g | sed 's#/$##g'`
        ;;

    "2")
        printf "Please choose a username for the GeoServer admin account.\n"
        respond "username" "$username" "3"
        username=$choice
        ;;

    "3")
        printf "Please choose a password for the GeoServer admin account.\n"
        respond "password" "$password" "3"
        password=$choice
        ;;

    "9")
        printf "Saving changes."
        fin="1"
        #TODO configure a check to prevent rerunning this

cat << EOF > /usr/share/opengeo-suite-data/geoserver_data/security/users.properties
$username=$password,ROLE_ADMINISTRATOR
# These are sample users you may uncomment if you want to test locking down wfs (see service.properties)
#wfst=wfst,ROLE_WFS_READ,ROLE_WFS_WRITE
#wfs=wfs,ROLE_WFS_READ
EOF

if [ ! -d "/var/lib/tomcat5/webapps/geoserver" ]; then
       unzip  -o /var/lib/tomcat5/webapps/geoserver.war  -d /var/lib/tomcat5/webapps/geoserver  > /dev/null 2>&1
fi
sed -i -e "s/MYHOST/$myhost/g" /var/lib/tomcat5/webapps/geoserver/WEB-INF/web.xml

if [ -e /etc/sysconfig/iptables ] && [ ! `cat /etc/sysconfig/iptables | grep 8080 |wc -l` ]; then
	iptables -I INPUT -p tcp --dport 8080 -j ACCEPT
	iptables-save > /etc/sysconfig/iptables
fi

if [ -e /sbin/service ]; then
	/sbin/service tomcat5 restart
else
	/etc/init.d/tomcat5 restart
fi
    ;;

    "0")
        echo "Aborting, changes not saved."
        exit 255
    ;;
  esac
}

check_root
while [ $fin -eq 0 ]; do
  menu
done

exit 0
