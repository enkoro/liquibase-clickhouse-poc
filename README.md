# WIP

Docker compose with clickhouse-server, clickhouse-ui, migrations one-shot container.
Migrations should be placed inside ./sql directory.

## Run

```bash
./run_poc.sh
```

## TODO

- [ ] Set versions as ARG inside Dockerfile
- [ ] Implement rollback
- [ ] Implement declarative schema version applying
