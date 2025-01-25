#!/bin/bash

# Actualizar los repositorios e instalar paquetes
sudo apt update

sudo apt install -y openjdk-11-jdk tomcat9 tomcat9-admin

sudo apt-get update && sudo apt-get -y install maven

# Crear un grupo y un usuario para Tomcat
sudo groupadd tomcat9

sudo useradd -s /bin/false -g tomcat9 -d /etc/tomcat9 tomcat9

# Iniciamos Tomcat
sudo systemctl start tomcat9

# Configurar usuario administrador en Tomcat
sudo bash -c 'cat <<EOF > /etc/tomcat9/tomcat-users.xml
<?xml version="1.0" encoding="UTF-8"?>
<tomcat-users xmlns="http://tomcat.apache.org/xml"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd"
version="1.0">
<role rolename="admin"/>
<role rolename="admin-gui"/>
<role rolename="manager"/>
<role rolename="manager-gui"/>
<user username="alumno"
password="1234"
roles="admin,admin-gui,manager,manager-gui"/>
</tomcat-users>
EOF'

# Reiniciamos Tomcat

# Permitir acceso remoto a los paneles de Tomcat
sudo bash -c 'cat <<EOF > /usr/share/tomcat9-admin/host-manager/META-INF/context.xml
<?xml version="1.0" encoding="UTF-8"?>
<Context antiResourceLocking="false" privileged="true" >
<CookieProcessor className="org.apache.tomcat.util.http.Rfc6265CookieProcessor"
sameSiteCookies="strict" />
<Valve className="org.apache.catalina.valves.RemoteAddrValve"
allow="\d+\.\d+\.\d+\.\d+" />
<Manager sessionAttributeValueClassNameFilter="java\.lang\.(?
˓→:Boolean|Integer|Long|Number|String)|org\.apache\.catalina\.filters\.CsrfPreventionFilter\
˓→$LruCache(?:\$1)?|java\.util\.(?:Linked)?HashMap"/>
</Context>
EOF'

# Reiniciamos Tomcat
sudo systemctl restart tomcat9

# Volvemos a modificar los usuarios de Tomcat
sudo bash -c 'cat <<EOF > /etc/tomcat9/tomcat-users.xml
<?xml version="1.0" encoding="UTF-8"?>
<tomcat-users xmlns="http://tomcat.apache.org/xml"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd"
version="1.0">
<role rolename="admin"/>
<role rolename="admin-gui"/>
<role rolename="manager"/>
<role rolename="manager-gui"/>
<user username="alumno"
password="1234"
roles="admin,admin-gui,manager,manager-gui"/>
<user username="deploy" password="1234" roles="manager-script"/>
</tomcat-users>
EOF'

# Añadimos el server
if ! grep -q "<id>Tomcat</id>" /etc/maven/settings.xml; then
    sudo sed -i '/<servers>/a \
    <server>\n\
        <id>Tomcat</id>\n\
        <username>deploy</username>\n\
        <password>1234</password>\n\
    </server>' /etc/maven/settings.xml
fi

cd

sudo mvn archetype:generate -DgroupId=org.zaidinvergeles -DartifactId=tomcat-war -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false

cd tomcat-war

sudo sed -i '/<\/build>/i \
        <plugins>\n\
            <plugin>\n\
                <groupId>org.apache.tomcat.maven</groupId>\n\
                <artifactId>tomcat7-maven-plugin</artifactId>\n\
                <version>2.2</version>\n\
                <configuration>\n\
                    <url>http://localhost:8080/manager/text</url>\n\
                    <server>Tomcat</server>\n\
                    <path>/despliegue</path>\n\
                </configuration>\n\
            </plugin>\n\
        </plugins>' pom.xml

mvn tomcat7:deploy

cd 

sudo apt-get update && sudo apt-get -y install git

sudo git clone https://github.com/cameronmcnz/rock-paper-scissors.git

cd rock-paper-scissors

git checkout patch-1

sudo sed -i '/<\/build>/i \
        <plugins>\n\
            <plugin>\n\
                <groupId>org.apache.tomcat.maven</groupId>\n\
                <artifactId>tomcat7-maven-plugin</artifactId>\n\
                <version>2.2</version>\n\
                <configuration>\n\
                    <url>http://localhost:8080/manager/text</url>\n\
                    <server>Tomcat</server>\n\
                    <path>/piedrapapeltijeras</path>\n\
                </configuration>\n\
            </plugin>\n\
        </plugins>' pom.xml

# mvn tomcat7:deploy
