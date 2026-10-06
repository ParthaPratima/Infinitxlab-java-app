FROM tomcat:9.0-jdk17-temurin

LABEL application="infinitx-lab"
LABEL maintainer="InfinitX Lab"

RUN rm -rf /usr/local/tomcat/webapps/*

COPY target/infinitx-lab.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
