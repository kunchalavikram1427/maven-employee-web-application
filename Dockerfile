FROM maven:3.8.2-openjdk-11 AS build
WORKDIR /app
COPY src src
COPY pom.xml .
RUN mvn clean package

# Package stage
FROM tomcat:9.0
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps
EXPOSE 8080