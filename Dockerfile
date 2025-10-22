# Multi-stage Dockerfile for Spring Boot Application
# Build stage
FROM eclipse-temurin:17-jdk-alpine AS build

WORKDIR /app

# Copy pom and sources
COPY pom.xml mvnw .mvn/ ./
COPY src ./src

# Download dependencies, build application
RUN ./mvnw package -DskipTests

# Runtime stage
FROM eclipse-temurin:17-jre-alpine

# Set environment variables for JVM tuning
ENV JAVA_OPTS="-XX:MaxRAMPercentage=80.0 -XX:+UseContainerSupport -XshowSettings:vm"
# You can pass extra JAVA_OPTS at docker run time for further tuning

# Non-root user for security
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

# Expose port 8080
EXPOSE 8080

ENTRYPOINT exec java $JAVA_OPTS -jar app.jar
