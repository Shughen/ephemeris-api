# Build stage
FROM clojure:lein-2.11.2 AS builder

WORKDIR /app

# Copy project files
COPY project.clj .
COPY src ./src
COPY resources ./resources

# Build uberjar
RUN lein uberjar

# Runtime stage
FROM eclipse-temurin:8-jre

WORKDIR /srv

# Copy the built jar from builder stage
COPY --from=builder /app/target/ephemeris-api-0.0.1-SNAPSHOT-standalone.jar /srv/ephemeris-api-0.0.1-SNAPSHOT-standalone.jar
EXPOSE 8080

CMD ["java", "-Dnomad.env=prod", "-jar", "/srv/ephemeris-api-0.0.1-SNAPSHOT-standalone.jar"]
