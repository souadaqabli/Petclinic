FROM eclipse-temurin:8-jre
EXPOSE 8082
ADD target/petclinic.war petclinic.war
ENTRYPOINT ["java", "-jar", "petclinic.war"]
