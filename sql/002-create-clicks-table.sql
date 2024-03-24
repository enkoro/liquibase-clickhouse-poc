--liquibase formatted sql
--changeset test:create-clicks-table
create table dummy.clicks
(
    date      DateTime,
    user_id   Int64,
    banner_id String
) engine = MergeTree() order by user_id settings index_granularity = 2;