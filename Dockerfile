FROM tomcat:9.0
COPY . target/*.war /usr/local/tomcat/
CMD ["catalina.sh", "run"]