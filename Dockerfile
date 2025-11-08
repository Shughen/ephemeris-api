# Build stage
FROM clojure:lein-2.11.2 AS builder

WORKDIR /app

# Copy project files
COPY project.clj .
COPY src ./src
COPY resources ./resources

# Build uberjar
RUN lein uberjar
RUN ls -la target/

# Rename JAR to fixed name for easier COPY
RUN bash -c 'mv target/*-standalone.jar target/server.jar'
# Runtime stage
FROM eclipse-temurin:8-jre

WORKDIR /srv

# Copy the built jar from builder stage
COPY --from=builder /app/target/server.jar /srv/server.jar
EXPOSE 8080

CMD ["java", "-Dnomad.env=prod", "-Dephemeris.api.port=8080", "-Dephemeris.api.base=/", "-jar", "/srv/server.jar"]
