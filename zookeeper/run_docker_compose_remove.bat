cd %~dp0
@FOR /f "tokens=*" %%i IN ('docker-machine env') DO @%%i
docker-compose kill
docker-compose rm
pause