# Cloning Stage
FROM alpine:3.18 AS clone

RUN apt-get update && apt-get install -y git
WORKDIR /gittmp/

RUN git clone https://github.com/aldairjpalma/TestBot.git
RUN git submodule init
RUN git submodule update
RUN mv ARJIpom.xml ./ARJI/pom.xml

#Building  Stage
FROM maven:3.8.3-openjdk-17 AS build
WORKDIR /tmp/
COPY --from=clone /gittmp/ARJI/ /tmp/
COPY --from=clone /gittmp/Driver/ /tmp/
COPY --from=clone /gittmp/pom.xml /tmp/pom.xml
COPY --from=clone /gittmp/.gitmodules /tmp/.gitmodules
RUN mvn clean package

# Run Stage
FROM openjdk:17-alpine
COPY --from=build /tmp/Driver/target/*.jar /user/testbot/
RUN mv /user/tesbot/Interweb-jar-with-dependencies.jar /user/testbot/app.jar
WORKDIR /user/testbot/
CMD ["java", "-jar", "app.jar"]
