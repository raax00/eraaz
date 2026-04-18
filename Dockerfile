# Step 1: Code ko build karne ke liye Maven ka use
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Step 2: Sirf run karne ke liye lightweight Java image ka use
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Render ke liye port expose karna
EXPOSE 8080

# API ko start karne ka command
ENTRYPOINT ["java", "-jar", "app.jar"]
