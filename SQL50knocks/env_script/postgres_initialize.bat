@echo off

docker compose down
docker compose up -d

echo #================
echo # login postgres
echo #================

:loop
timeout 5 /NOBREAK > NUL
docker compose exec db psql -U postgres -h localhost -p 5432
if not %errorlevel% == 0 (
    echo wait PostgreSQL server...
    docker compose ps
    goto loop
)
