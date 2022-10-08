[![Build Status](http://3.110.43.167:8080/buildStatus/icon?job=BuildStatus)](http://3.110.43.167:8080/job/BuildStatus/)
#  [info]: Sample Maven Application: maven-employee-web-application
maven-employee-web-application.

### References
 - https://maven.apache.org/pom.html
 - https://maven.apache.org/settings.html

### How to build
```
docker build -t employee:4.0 .
```
```sh
docker build --build-arg git_url=https://github.com/kunchalavikram1427/maven-employee-web-application.git --build-arg project_name=maven-employee-web-application  --build-arg artifact_id=employee -t employee:4.0 .
```
```
FROM alpine/git as gitclone
ARG git_url
WORKDIR /app
RUN git clone ${git_url}

FROM maven:3.8.2-openjdk-11 as build
ARG project_name
WORKDIR /app
COPY --from=gitclone /app/${project_name}/ ./
RUN mvn package

FROM tomcat:9.0
ARG artifact_id
ARG version
COPY --from=build /app/target/${artifact_id}.war /usr/local/tomcat/webapps
EXPOSE 8080
```
### Maintainer
- Vikram K (www.youtube.com/c/devopsmadeeasy)

### Original Author
- Unknown as I have cloned this repository long back and updating/using ever since. All credits to the original author. If you are the original author, kindly contact me on kunchalavikram1427@gmail.com If you are concerned about using the source.
