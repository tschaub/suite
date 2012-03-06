
# install java
sudo su - root
add-apt-repository "deb http://archive.canonical.com/ lucid partner"
apt-get update
apt-get -y install sun-java6-jdk

# install jetty
useradd -s /bin/bash web
apt-get -y install jetty
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/jetty
sed -i 's/#JETTY_USER=jetty/JETTY_USER=web/g' /etc/default/jetty
chown web /var/log/jetty
chown web /var/lib/jetty

# install svn
apt-get -y subversion

# install hudson
cd /var/lib/jetty/webapps
su -c "wget http://hudson-ci.org/latest/hudson.war" web
/etc/init.d/jetty start
sleep 5
/etc/init.d/jetty stop
cd /home/web/.hudson/plugins
su -c "wget http://hudson-ci.org/latest/parameterized-trigger.hpi" web
su -c "wget http://hudson-ci.org/latest/join.hpi" web
su -c "svn co http://svn.opengeo.org/suite/sandbox/system-test/hudson/home /tmp/hudson" web
su -c "cp -R /tmp/hudson/* /home/web/.hudson"

# install apache
apt-get -y install apache2
cd /etc/apache2/mods-enabled
ln -sf ../mods-available/proxy.load
ln -sf ../mods-available/proxy_http.load

cd /etc/apache2/sites-available
sed -i 's#</VirtualHost>##g' default && 
echo "    <Proxy *>" >> default &&
echo "      Order allow,deny" >> default &&
echo "      Allow from all" >> default &&
echo "    </Proxy>" >> default &&
echo "" >> default &&
echo "    ProxyRequests Off" >> default &&
echo "    ProxyPreserveHost On" >> default &&
echo "" >> default &&
echo "    ProxyPass /geoserver/ http://localhost:9090/geoserver/" >> default &&
echo "    ProxyPassReverse /geoserver/ http://localhost:9090/geoserver/" >> default &&
echo "" >> default &&
echo "    ProxyPass /hudson/ http://localhost:8080/hudson/" >> default &&
echo "    ProxyPassReverse /hudson/ http://localhost:8080/hudson/" >> default &&
echo "" >> default &&
echo "</VirtualHost>" >> default
/etc/init.d/apache2 restart

# install tomcat
cd /opt
wget http://apache.skazkaforyou.com//tomcat/tomcat-6/v6.0.29/bin/apache-tomcat-6.0.29.tar.gz
tar xzvf apache-tomcat-6.0.29.tar.gz
chown -R web apache-tomcat-6.0.29
ln -sf apache-tomcat-6.0.29 tomcat
cd apache-tomcat-6.0.29/bin
echo "CATALINA_PID=/home/web/tomcat.pid" >> setclasspath.sh
echo "JAVA_OPTS=\"-Xms128m -Xmx512m -XX:SoftRefLRUPolicyMSPerMB=36000 -XX:MaxPermSize=256m -DGEOSERVER_DATA_DIR=/var/lib/geoserver_data/suite_default\"" >> setclasspath.sh
su -c "wget http://svn.opengeo.org/suite/sandbox/system-test/tomcat/kill.sh" web
chmod +x kill.sh
cd ../conf
sed -i 's/port="8080"/port="9090"/g' server.xml
sed -i 's/redirectPort="8443"/redirectPort="9443"/g' server.xml

# install jboss
cd /opt
wget http://sourceforge.net/projects/jboss/files/JBoss/JBoss-5.1.0.GA/jboss-5.1.0.GA-jdk6.zip
apt-get -y install unzip
unzip jboss-5.1.0.GA-jdk6.zip
chown -R web jboss-5.1.0.GA
ln -sf jboss-5.1.0.GA jboss
cd jboss-5.1.0.GA/bin
echo "JAVA_OPTS=\"\$JAVA_OPTS -DGEOSERVER_DATA_DIR=/var/lib/geoserver_data/suite_default\"" >> run.conf
su -c "wget http://svn.opengeo.org/suite/sandbox/system-test/jboss/start.sh" web
su -c "wget http://svn.opengeo.org/suite/sandbox/system-test/jboss/kill.sh" web
chmod +x start.sh
chmod +x kill.sh
cd ../server/default/conf/bindingservice.beans/META-INF/
sed -i 's/"port">8080/"port">9090/g' bindings-jboss-beans.xml
sed -i 's/"port">8443/"port">9443/g' bindings-jboss-beans.xml

# install jmeter
cd /opt
wget http://apache.mobiles5.com//jakarta/jmeter/binaries/jakarta-jmeter-2.4.tgz
tar xzvf jakarta-jmeter-2.4.tgz
ln -sf jakarta-jmeter-2.4 jmeter
cd jmeter/lib
wget http://repo.opengeo.org/jython/jython/2.5.1/jython-2.5.1.jar

# install postgres/postgis
apt-get install postgresql-8.4 postgresql-server-dev-8.4 postgresql-contrib-8.4 libpq-dev postgis postgresql-8.4-postgis
/etc/init.d/postgresql-8.4 stop
cd /etc/postgresql/8.4/main
echo "host    all         postgres         127.0.0.1/32          trust" >> pg_hba.conf
echo "host    all         postgres         ::1/128          trust" >> pg_hba.conf
/etc/init.d/postgresql-8.4 start

# initialize the database
su - postgres
createdb medford
createlang plpgsql medford
psql medford -f /usr/share/postgresql/8.4/contrib/postgis.sql
psql medford -f /usr/share/postgresql/8.4/contrib/spatial_ref_sys.sql

cd /tmp
wget http://data.opengeo.org/suite/medford_taxlots.zip
unzip medford_taxlots.zip
psql -f medford_taxlots_schema.sql medford
psql -f medford_taxlots.sql medford
exit

# set up the GEOSERVER_DATA_DIR
mkdir /var/lib/geoserver_data
cd /var/lib/geoserver_data/
mkdir suite_default
chown web suite_default
cd suite_default
su -c "svn co http://svn.opengeo.org/suite/trunk/data_dir ." web
cd workspaces/medford/Taxlots
sed -i 's/port">54321/port">5432/g' datastore.xml

# install ec2-api-tools
cd /opt
wget "http://www.amazon.com/gp/redirect.html/ref=aws_rc_ec2tools?location=http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip&token=A80325AA4DAB186C80828ED5138633E3F49160D9" -O ec2-api-tools.zip 
unzip ec2-api-tools.zip
ln -sf ec2-api-tools-* ec2-api-tools

echo "export EC2_HOME=/opt/ec2-api-tools" > /home/web/.bash_profile &&
echo "export PATH=\$PATH:\$EC2_HOME/bin" >> /home/web/.bash_profile &&
echo "export EC2_PRIVATE_KEY=/home/web/.ec2/pk-PISUFPUN445RP3HBFC4VUG2V44LJJ7N2.pem" >> /home/web/.bash_profile &&
echo "export EC2_CERT=/home/web/.ec2/cert-PISUFPUN445RP3HBFC4VUG2V44LJJ7N2.pem" >> /home/web/.bash_profile &&
echo "export JAVA_HOME=/usr/lib/jvm/java-6-sun" >> /home/web/.bash_profile

#TODO: copy the primary key and ceritificate into the right directory
