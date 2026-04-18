# Step 1: Code ko build karne ke liye Maven aur Eclipse Temurin ka use
FROM maven:3.8.5-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
# Test files ko compile hone se rokne ke liye fixed command
RUN mvn clean package -Dmaven.test.skip=true

# Step 2: Sirf run karne ke liye lightweight Eclipse Temurin JRE image
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Render ke liye port expose karna
EXPOSE 8080

# API ko start karne ka command
ENTRYPOINT ["java", "-jar", "app.jar"]
