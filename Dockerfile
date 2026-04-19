#Stage 1: Build war file
FROM maven:3.9.9-eclipse-temurin-21 AS build

WORKDIR /app

COPY pom.xml .
COPY src src

RUN mvn clean package -DskipTests 

# Stage 2: Deploy to tomcat
FROM tomcat:9.0-jdk21-temurin

# create a user and group to run app instead of root for security purpose 
ENV APPUSER=appuser
ENV APPUID=2000
ENV APPGID=2000

RUN  groupadd -g ${APPGID} ${APPUSER} && \
    useradd -m -u ${APPUID} -g ${APPGID} -s /bin/sh ${APPUSER}

# Clean default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file into the ROOT of Tomcat
COPY --from=build /app/target/ABCtechnologies-1.0.war \
    /usr/local/tomcat/webapps/ROOT.war 

RUN chown -R ${APPUSER}:${APPUSER} /usr/local/tomcat

USER ${APPUSER}

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]

