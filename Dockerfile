FROM tomcat:latest
LABEL maintainer="Asha Jain"
ADD ./sample.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
