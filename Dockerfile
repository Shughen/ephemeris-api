FROM openjdk:8-jre-slim
ADD target/server.jar /srv/ephemeris-api.jar

EXPOSE 8080

CMD ["java", "-Dnomad.env=prod", "-jar", "/srv/ephemeris-api.jar"]
