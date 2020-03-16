---
title: Ejecución de Huemul con datos del Sistema Financiero Chileno
subtitle: Guía para la ejecución de Huemul con datos del Sistema Financiero Chileno en Cluster HortonWorks.
excerpt: >-
  Los datos del sistema financiero permiten visualizar el estado de resultados y balance de los distintos bancos existentes en Chile a cierta fecha. Este ejemplo permite cargar estos archivos, estructurarlos y dejarlos disponibles en tablas en Hive
date: '2019-10-15'
thumb_img_path: images/huemul_intro_02_mini.png
content_img_path: images/huemul_intro_02.png
layout: post
---

## Introducción
Los datos del sistema financiero permiten visualizar el estado de resultados y balance de los chilenos a cierta fecha. Este ejemplo permite cargar estos archivos al cluster BigData, estructurarlos y dejarlos disponibles en tablas sobre Hive.

Puedes descargar este documento en versión PDF desde [aquí](/pdf/HuemulSolutions%20-%20Ejecucion%20con%20datos%20del%20Sistema%20Financiero%20Chileno.pdf)

Para ejecutar este ejemplo, se han creado tres ficheros que contienen todo lo necesario, se explican a continuación:

* **demo-sbif.zip**: contiene los datos del proyecto, y archivo ejemplo de configuración para connectionString del modelo de control. Los datos que contiene son los siguientes:
     - NEGOCIO_201806: Datos de negocios identificados para esta demo
     - PRODUCTO_201806: Datos de productos permitidos para esta demo
     - PLANCUENTA_GESTION_001: Asignación de productos y negocios a las cuentas contables.
     - 201806: Carpeta que contiene los datos del sistema financiero para junio del 2018
     - 201807: Carpeta que contiene los datos del sistema financiero para julio del 2018
* **huemul_install_sbif.sh**: Shell para crear directorios en HDFS y copiar archivo RAW.
* **huemul-drivers.zip**: Drivers utilizados por Huemul, contiene lo siguiente:
     - huemul-bigdatagovernance-2.4.jar: Framework Huemul BigData
     - huemul-sql-decode-1.0.jar: Componente de Huemul para obtener traza
     - postgresql-9.4.1212.jar: Driver para conexión con modelo de control implementado en PostgreSQL
     - ojdbc7.jar: Driver para conexión con modelo de control implementado en Oracle
     - mysql-connector-java-5.1.48.jar: Driver para conexión con modelo de control implementado en MySQL
     - mssql-jdbc-7.2.1.jre8.jar: Driver para conexión con modelo de control implementado en SQL Server.

Los ficheros pueden ser descargados desde el siguiente link:
* [demo-sbif.zip](/ejemplos/sbif_24/demo-sbif.zip)
* [huemul_install_sbif.sh](/ejemplos/sbif_24/huemul_install_sbif.sh)
* [huemul-drivers.zip](/ejemplos/sbif_24/huemul-drivers.zip)


Para efectos de este ejemplo, los códigos se han ejecutado sobre un ambiente Hortonworks versión 2.6.5 en modo Sandbox, por tanto los tiempos de ejecución no son representativos.

A continuación, se explican los pasos necesarios para subir los datos, ejecutar los procesos y visualizar los resultados.


## Contexto
Este ejemplo permite ver las distintas opciones de ingestas de datos, y la forma en que Huemul permite la implementación de forma muy sencilla:
![Branching](/images/huemul_Ejemplo_sbif.png)
<p align="center" style="font-size:10px" ><b>figura 1.1. Estructura de carpetas base en HDFS</b></p>


Tal como se muestra en la imagen anterior, hay múltiples escenarios para ingestar archivos:

* **una interfaz carga una tabla maestra**: una interfaz (por ejemplo CODIFIS.TXT) se carga sobre una tabla (tbl_comun_institucion). Este ejemplo carga una tabla maestra, es decir, los datos nuevos sobreescriben los datos antiguos
* **una interfaz carga una tabla transaccional**: a diferencia del ejemplo anterior, la tabla de destino es una tabla transaccional, eso significa que tiene una columna de periodo. Los datos quedan como una foto mes a mes.
* **Muchas interfaces cargan una tabla transaccional**: en este ejemplo se pueden ver como múltiples interfaces se procesan para dejar una sola tabla transaccional. Para ver este ejemplo debes ver el código “process_eerr_mes.scala”
* **Tablas que cargan tablas**: es común que luego de ingestar datos, estos sean procesados para generar nuevos datos. El proceso “process_gestion_mes.scala” permite ver la forma de tomar tablas ya existentes para crear nuevas tablas con nueva información

## Ejecutar Script de ambientación en Clúster

Lo primero que se requiere es subir los archivos de ambientación al cluster, para ello debes seguir los siguientes pasos:

Abrir shell y dar acceso de ejecución sobre el fichero huemul_install_sbif.sh
```shell
chmod 775 huemul_install_sbif.sh
```

Luego, ejecuta el script:
```shell
./huemul_install_sbif.sh
```

Este comando tomará un poco de tiempo, debido a que realiza los siguientes pasos:

* **a.** creación de estructuras en HDFS
* **b.** creación de bases de datos en HIVE
* **c.** descomprimir archivos de datos
* **d.** copiar archivos de datos en rutas RAW
* **e.** descomprimir dependencias requeridas.

Una vez que el script de ambientación ha terminado correctamente, podrás ver las estructuras creadas en el path user/data/production
![figura 2.1. Estructura de carpetas base en HDFS](/images/paper_sbif/imagen_02_01.png)
<p align="center" style="font-size:10px" ><b>figura 2.1. Estructura de carpetas base en HDFS</b></p>

En el path /user/data/production/raw/sbif/201807

![figura 2.2. ficheros del sistema financiero, con fecha julio del 2018.](/images/paper_sbif/imagen_02_02.png)
<p align="center" style="font-size:10px" ><b>figura 2.2. ficheros del sistema financiero, con fecha julio del 2018.</b></p>

Finalmente, debes incluir los archivos JAR compilados de los proyectos demo:

* **demo_settings-2.4.jar**: Contiene los path y connectionString globales para todos los proyectos.
     - Este proyecto usa los siguientes archivos paramétricos:
     - prod-demo-setting-control-connection: Contiene el connectionString para el modelo de control
     - prod-demo-setting-impala-connection: Contiene el connectionString para conectar con Impala
* **demo_catalogo-2.4.jar**: Carga los datos de productos y negocios. Estas interfaces fueron creadas manualmente como ejemplo para esta demo
* **demo_sbif-2.4.jar**: Carga los datos descargados desde el sitio web de la CMF

Puedes descargar estos binarios desde los siguientes links:
* [demo_settings-2.4.jar](/ejemplos/sbif_24/demo_settings-2.4.jar)
* [demo_catalogo-2.4.jar](/ejemplos/sbif_24/demo_catalogo-2.4.jar)
* [demo_sbif-2.4.jar](/ejemplos/sbif_24/demo_sbif-2.4.jar)

También puedes descargar el código fuente desde GitHub y compilar el código tú mismo:
* git@github.com:HuemulSolutions/demo_settings.git
* git@github.com:HuemulSolutions/demo_catalogo.git
* git@github.com:HuemulSolutions/demo_sbif.git



## Ejecutar Script de Configuración de Modelo de Control.
Huemul requiere de un modelo de control, el cual registra toda la actividad de Huemul, tanto a nivel de procesos (ejecuciones, estado, etc), como también de los metadatos de las interfaces leidas y las tablas creadas.

El modelo de control puede ser implementado en los siguientes motores de base de datos:
* PostgreSQL
* MySQL
* SQL Server
* Oracle

Para efectos de esta guía, utilizaremos una base de datos PostgreSQL versión 10.0 que será creada sobre Azure. 
![figura 4.1. Creación de Servidor PostgreSQL en Azure.](/images/paper_sbif/imagen_04_01.png)
<p align="center" style="font-size:10px" ><b>figura 4.1. Creación de Servidor PostgreSQL en Azure.</b></p>

Una vez creado el servidor de base de datos PostgreSQL, creamos una base de datos llamada “huemul_control”. (NOTA: revisa que la IP del clúster pueda acceder al servidor de BBDD).

Luego, debes crear las tablas del modelo de control, para ello debes descargar el script con la versión de Huemul que estés usando (en nuestro caso la versión 2.4), el link es el siguiente

https://github.com/HuemulSolutions/huemul-bigdatagovernance/blob/master/src/main/resources/Instalacion/huemul_bdg_2.4_minor.sql

En nuestro caso utilizamos dBeaver para trabajar con la base de datos y ejecutar el script.
![figura 4.2. Script SQL ejecutado correctamente.](/images/paper_sbif/imagen_04_02.png)
<p align="center" style="font-size:10px" ><b>figura 4.2. Script SQL ejecutado correctamente.</b></p>

Finalmente, debes editar el archivo “prod-demo-setting-control-connection.set” para configurar el connectionString correspondiente a la conexión, este archivo permite que Huemul se comunique con la base de datos PostgreSQL.

![figura 4.3. Ejemplo connectionString para modelo de control..](/images/paper_sbif/imagen_04_03.png)
<p align="center" style="font-size:10px" ><b>figura 4.3. Ejemplo connectionString para modelo de control..</b></p>

## Ejecución del código

Ahora que ya están ambientados los componentes, podemos ejecutar los códigos en spark usando huemul:

Se deben ejecutar en el siguiente orden:

* **com.yourcompany.catalogo.process_negocio**: carga los datos de negocios.
* **com.yourcompany.catalogo.process_producto**: carga los datos de productos.
* **com.yourcompany.sbif.process_mensual**: carga los siguientes datos:
     - **process_institucion**: carga datos de instituciones en tabla maestra. Esta ingesta permite ver el tratamiento de datos semi-estructurados
	 - **process_institucion_mes**: carga datos de instituciones con foto mensual
	 - **process_planCuenta**: carga datos del plan de cuentas en tabla maestra
	 - **process_planCuenta_mes**: carga datos del plan de cuentas con foto mensual
	 - **process_eerr_mes**: carga los datos de estados de resultados y balances de todos los bancos en forma mensual
	 
### Ejecución process_negocio
Se ejecuta con el siguiente comando:

```shell
spark-submit --master local --jars huemul-bigdatagovernance-2.4.jar,huemul-sql-decode-1.0.jar,demo_settings-2.4.jar,demo_catalogo-2.4.jar,postgresql-9.4.1212.jar --class com.yourcompany.catalogo.process_negocio  demo_sbif-2.4.jar environment=production,ano=2018,mes=6
```

El resultado de esta ejecución es el siguiente:
![figura 3.1. Ejecución](/images/paper_sbif/imagen_03_01.png)
<p align="center" style="font-size:10px" ><b>figura 3.1. Ejecución</b></p>

La siguiente imagen muestra la tabla cargada con los datos:
![figura 3.2. Resultados de la ejecución del process_negocio](/images/paper_sbif/imagen_03_02.png)
<p align="center" style="font-size:10px" ><b>figura 3.2. Resultados de la ejecución del process_negocio</b></p>

### Ejecución process_producto
Se ejecuta con el siguiente comando:

```shell
spark-submit --master local --jars huemul-bigdatagovernance-2.4.jar,huemul-sql-decode-1.0.jar,demo_settings-2.4.jar,demo_catalogo-2.4.jar,postgresql-9.4.1212.jar --class com.yourcompany.catalogo.process_producto  demo_sbif-2.4.jar environment=production,ano=2018,mes=6
```

El resultado de esta ejecución es el siguiente:
![figura 3.3. Ejecución](/images/paper_sbif/imagen_03_03.png)
<p align="center" style="font-size:10px" ><b>figura 3.3. Ejecución</b></p>

La siguiente imagen muestra la tabla cargada con los datos:
![figura 3.4. Resultados de la ejecución del process_negocio](/images/paper_sbif/imagen_03_04.png)
<p align="center" style="font-size:10px" ><b>figura 3.4. Resultados de la ejecución del process_producto</b></p>

### Ejecución process_mensual
Se ejecuta con el siguiente comando:

```shell
spark-submit --master local --jars huemul-bigdatagovernance-2.4.jar,huemul-sql-decode-1.0.jar,demo_settings-2.4.jar,demo_catalogo-2.4.jar,postgresql-9.4.1212.jar --class com.yourcompany.sbif.process_mensual  demo_sbif-2.4.jar environment=production,ano=2018,mes=6
```

El resultado de esta ejecución es el siguiente:
![figura 3.5. Ejecución](/images/paper_sbif/imagen_03_05.png)
<p align="center" style="font-size:10px" ><b>figura 3.5. Ejecución</b></p>

La siguiente imagen muestra la tabla tbl_comun_institucion con los datos cargados:
![figura 3.6. tabla tbl_comun_institucion](/images/paper_sbif/imagen_03_06.png)
<p align="center" style="font-size:10px" ><b>figura 3.6. tabla tbl_comun_institucion</b></p>

La siguiente imagen muestra la tabla tbl_comun_institucion_mes con los datos cargados:
![figura 3.7. tabla tbl_comun_institucion_mes](/images/paper_sbif/imagen_03_07.png)
<p align="center" style="font-size:10px" ><b>figura 3.7. tabla tbl_comun_institucion_mes</b></p>

La siguiente imagen muestra la tabla tbl_sbif_plancuenta con los datos cargados
![figura 3.8. tabla tbl_sbif_plancuenta](/images/paper_sbif/imagen_03_08.png)
<p align="center" style="font-size:10px" ><b>figura 3.8. tabla tbl_sbif_plancuenta</b></p>

La siguiente imagen muestra la tabla tbl_sbif_plancuenta_mes con los datos cargados:
![figura 3.9. tabla tbl_sbif_plancuenta_mes](/images/paper_sbif/imagen_03_09.png)
<p align="center" style="font-size:10px" ><b>figura 3.9. tabla tbl_sbif_plancuenta_mes</b></p>

La siguiente imagen muestra la tabla tbl_sbif_eerr_mes con los datos cargados:
![figura 3.10. tabla tbl_sbif_eerr_mes](/images/paper_sbif/imagen_03_10.png)
<p align="center" style="font-size:10px" ><b>figura 3.10. tabla tbl_sbif_eerr_mes</b></p>

Finalmente, se muestra un resumen de los dos períodos cargados en la tabla tbl_sbif_eerr_mes:
![figura 3.11. Resumen de dos periodos cargados en tabla tbl_sbif_eerr_mes](/images/paper_sbif/imagen_03_11.png)
<p align="center" style="font-size:10px" ><b>figura 3.11. Resumen de dos periodos cargados en tabla tbl_sbif_eerr_mes</b></p>
