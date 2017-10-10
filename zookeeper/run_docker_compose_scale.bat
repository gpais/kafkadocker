cd %~dp0
@FOR /f "tokens=*" %%i IN ('docker-machine env') DO @%%i
docker-compose scale servicea-app=3
pause