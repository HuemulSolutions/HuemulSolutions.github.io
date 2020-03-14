#!/bin/bash
clear
echo "Creating HDFS Paths: START"
hdfs dfs -mkdir /user
hdfs dfs -mkdir /user/data
hdfs dfs -mkdir /user/data/production
hdfs dfs -mkdir /user/data/production/temp
hdfs dfs -mkdir /user/data/production/raw
hdfs dfs -mkdir /user/data/production/master
hdfs dfs -mkdir /user/data/production/dim
hdfs dfs -mkdir /user/data/production/analytics
hdfs dfs -mkdir /user/data/production/reporting
hdfs dfs -mkdir /user/data/production/sandbox
hdfs dfs -mkdir /user/data/production/dqerror
hdfs dfs -mkdir /user/data/production/mdm_oldvalue
hdfs dfs -mkdir /user/data/production/backup
hdfs dfs -mkdir /user/data/experimental
hdfs dfs -mkdir /user/data/experimental/temp
hdfs dfs -mkdir /user/data/experimental/raw
hdfs dfs -mkdir /user/data/experimental/master
hdfs dfs -mkdir /user/data/experimental/dim
hdfs dfs -mkdir /user/data/experimental/analytics
hdfs dfs -mkdir /user/data/experimental/reporting
hdfs dfs -mkdir /user/data/experimental/sandbox
hdfs dfs -mkdir /user/data/experimental/dqerror
hdfs dfs -mkdir /user/data/experimental/mdm_oldvalue
hdfs dfs -mkdir /user/data/experimental/backup
echo "Creating HDFS Paths: FINISH"
echo "STARTING HIVE SETUP"
hive -e "CREATE DATABASE production_master;CREATE DATABASE experimental_master;CREATE DATABASE production_dim;CREATE DATABASE experimental_dim;CREATE DATABASE production_analytics;CREATE DATABASE experimental_analytics;CREATE DATABASE production_reporting;CREATE DATABASE experimental_reporting;CREATE DATABASE production_sandbox;CREATE DATABASE experimental_sandbox;CREATE DATABASE production_DQError;CREATE DATABASE experimental_DQError;CREATE DATABASE production_mdm_oldvalue;CREATE DATABASE experimental_mdm_oldvalue"
echo "Creating HDFS Paths: START"
hdfs dfs -mkdir /user/data/production/raw/catalogo
hdfs dfs -mkdir /user/data/production/raw/sbif
hdfs dfs -mkdir /user/data/production/master/catalogo
hdfs dfs -mkdir /user/data/production/master/sbif
unzip demo-sbif.zip
echo "copy data files to raw/sbif"
hdfs dfs -put 201806 /user/data/production/raw/sbif
hdfs dfs -put 201807 /user/data/production/raw/sbif
hdfs dfs -put -f NEGOCIO_201806.txt /user/data/production/raw/catalogo/
hdfs dfs -put -f PLANCUENTA_GESTION_001.txt /user/data/production/raw/catalogo/
hdfs dfs -put -f PRODUCTO_201806.txt /user/data/production/raw/catalogo/
unzip huemul-drivers.zip