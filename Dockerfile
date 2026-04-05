FROM tomcat:9.0
EXPOSE 8080
COPY target/petclinic.war /usr/local/tomcat/webapps/ROOT.war
