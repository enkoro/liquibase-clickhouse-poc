ARG MVN_VERSION=3.8.7
ARG LIQUIBASE_CLICKHOUSE_VERSION=0.7.2
ARG LIQUIBASE_VERSION=4.6.1

FROM maven:${MVN_VERSION}-openjdk-18-slim as build

ARG LIQUIBASE_CLICKHOUSE_VERSION
ARG DB_URL
ARG DB_USERNAME
ARG DB_PASSWORD

WORKDIR /build
RUN curl -L https://github.com/MEDIARITHMICS/liquibase-clickhouse/archive/refs/tags/${LIQUIBASE_CLICKHOUSE_VERSION}.tar.gz > ${LIQUIBASE_CLICKHOUSE_VERSION}.tar.gz && \
    tar zxvf ${LIQUIBASE_CLICKHOUSE_VERSION}.tar.gz
WORKDIR /build/liquibase-clickhouse-${LIQUIBASE_CLICKHOUSE_VERSION}
RUN mvn clean package -DskipTests
COPY liquibase.properties.tpl .
COPY eval_file.sh . 
RUN ./eval_file.sh liquibase.properties.tpl ../liquibase.properties

FROM liquibase/liquibase:${LIQUIBASE_VERSION}

ARG LIQUIBASE_CLICKHOUSE_VERSION

WORKDIR /liquibase
COPY --from=build /build/liquibase-clickhouse-${LIQUIBASE_CLICKHOUSE_VERSION}/target/liquibase-clickhouse-${LIQUIBASE_CLICKHOUSE_VERSION}-shaded.jar ./lib/clickhouse.jar
COPY root-changelog.xml ./changelog/
COPY sql/ ./changelog/sql/
COPY --from=build /build/liquibase.properties .
