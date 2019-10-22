Intrucciones para ejecutar el script.

Instrucciones de ejecución.

Tenemos dos casos (Docker y Windows), que difieren en los pasos iniciales.

1) En el caso de Docker lo primero que tenemos que hacer es asegurarnos de que nuestra contenedor se esté ejecutando.

sudo docker ps -a

2) Si su STATUS es 'Up' entonces podemos continuar, si no lo podemos iniciar con el comando:

sudo docker start [NOMBRE_CONTENEDOR]

3) Luego copiamos nuestro archivo .sql a nuestro contenedor, en este caso el archivo se llama DDL.sql y lo copiaremos en el directorio raíz de nuestro contenedor.

sudo docker cp sql/ddl/DDL.sql [NOMBRE_CONTENEDOR]:/ 

4) Entramos a nuestro contenedor:

sudo docker exec -it [NOMBRE_CONTENEDOR] bash

Nota: Desde aquí los pasos son los mismos para Windows y Docker. 

5) Ahora desde el directorio donde se encuentra nuestro script DDL.sql, basta con ejecutar el script desde la linea de comandos:

sqlcmd -S localhost -U SA -P "[PASSWORD]" -i DDL.sql

Nota1: El comando debe de ejecutarse con el usuario SA ya que usa la base de datos master.

Nota2: Puede que en algunos casos se deba especificar el path completo para el comando sqlcmd. Para la versión de Docker el path es '/opt/mssql-tools/bin' con lo que el comando quedaría: 

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "[PASSWORD]" -i DDL.sql
