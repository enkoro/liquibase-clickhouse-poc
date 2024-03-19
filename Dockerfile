FROM maven:3.8.7-openjdk-18-slim as build
WORKDIR /app
RUN curl -L https://github.com/MEDIARITHMICS/liquibase-clickhouse/archive/refs/tags/0.7.2.tar.gz > 0.7.2.tar.gz
RUN ls -lah
RUN tar zxvf 0.7.2.tar.gz
WORKDIR /app/liquibase-clickhouse-0.7.2
RUN mvn clean package -DskipTests

FROM liquibase/liquibase:4.6.1
WORKDIR /liquibase
COPY --from=build /app/liquibase-clickhouse-0.7.2/target/liquibase-clickhouse-0.7.2-shaded.jar ./lib/clickhouse.jar
COPY root-changelog.xml ./changelog/
COPY sql/ ./changelog/sql/
COPY liquibase.properties ./