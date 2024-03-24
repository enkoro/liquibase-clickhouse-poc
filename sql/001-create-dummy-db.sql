--liquibase formatted sql
--changeset test:create-dummy-database
create database if not exists dummy;