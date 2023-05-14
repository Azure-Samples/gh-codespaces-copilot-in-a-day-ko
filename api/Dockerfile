FROM openjdk:17-jdk-slim
# takes the jar file as an argument
ARG ARTIFACT_NAME
# assumes the application entry port is 8080
EXPOSE 8080

# The application's jar file
ARG JAR_FILE=${ARTIFACT_NAME}

# Add the application's jar to the container
ADD ${JAR_FILE} app.jar

# Run the jar file
ENTRYPOINT ["java","-jar","/app.jar"]