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
