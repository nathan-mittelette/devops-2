# Build
FROM maven:3.6.3-jdk-11 AS build
ENV MYAPP_HOME /opt/backend
WORKDIR $MYAPP_HOME
COPY pom.xml .
COPY src ./src
RUN mvn package -DskipTests

# Run
FROM openjdk:11-jre
ENV MYAPP_HOME /opt/backend
WORKDIR $MYAPP_HOME

# Download openTelemetry agent
ADD https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v1.7.2/opentelemetry-javaagent-all.jar .

COPY --from=build $MYAPP_HOME/target/*.jar $MYAPP_HOME/app.jar

EXPOSE 8080

ENTRYPOINT java -javaagent:${MYAPP_HOME}/opentelemetry-javaagent-all.jar \
     -jar app.jar -v