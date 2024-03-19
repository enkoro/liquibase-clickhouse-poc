# POC

## Prereq

- Running ClickHouse
- Migrations places in sql folder
- Correct credentials to connect to CH are set in _liquibase.properties_

## Build

```bash
docker build -t liquibase-ch:test .
```

## Run

```bash
docker run -it --rm liquibase-ch:test --defaultsFile=/liquibase/liquibase.properties --headless=true --logLevel=debug update
```
