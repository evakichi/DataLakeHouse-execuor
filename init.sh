#!/bin/bash

if ! . .env;then
	echo "ERR!"
	exit 255
fi

sed "s/__DOMAIN_NAME__/${STORAGE_SERVER_NAME}/g" Dockerfile.org > Dockerfile
sed "s/__DOMAIN_NAME__/${DOMAIN_NAME}/g" conf/nginx.conf.org > conf/nginx.conf

echo "spark.sql.extensions				org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions" > ./conf/spark-defaults.conf
echo "spark.sql.defaultCatalog			${SPARK_CATALOG_NAME}" >> ./conf/spark-defaults.conf
echo "spark.sql.catalog.${SPARK_CATALOG_NAME}			org.apache.iceberg.spark.SparkCatalog" >> ./conf/spark-defaults.conf
echo "spark.sql.catalog.${SPARK_CATALOG_NAME}.type		jdbc" >> ./conf/spark-defaults.conf
echo "spark.sql.catalog.${SPARK_CATALOG_NAME}.uri		jdbc:postgresql://${STORAGE_SERVER_NAME}:${POSTGRES_PORT}/${POSTGRES_DBNAME}" >> ./conf/spark-defaults.conf
echo "spark.sql.catalog.${SPARK_CATALOG_NAME}.jdbc.useSSL	true" >> ./conf/spark-defaults.conf
echo "spark.sql.catalog.${SPARK_CATALOG_NAME}.jdbc.user	${POSTGRES_USERNAME}" >> ./conf/spark-defaults.conf
echo "spark.sql.catalog.${SPARK_CATALOG_NAME}.io-impl		org.apache.iceberg.aws.s3.S3FileIO" >> ./conf/spark-defaults.conf
echo "spark.sql.catalog.${SPARK_CATALOG_NAME}.warehouse	s3://${SPARK_WAREHOUSE_NAME}" >> ./conf/spark-defaults.conf
echo "spark.sql.catalog.${SPARK_CATALOG_NAME}.s3.endpoint	https://${STORAGE_SERVER_NAME}:${MINIO_CLI_NGINX_PORT}/${SPARK_ENDPOINT_NAME}/" >> ./conf/spark-defaults.conf
echo "spark.sql.catalog."${SPARK_CATALOG_NAME}".jdbc.password	"${POSTGRES_PASSWORD} >> ./conf/spark-defaults.conf
echo "spark.sql.catalog.spark_catalog			org.apache.iceberg.spark.SparkSessionCatalog" >> ./conf/spark-defaults.conf
echo "spark.eventLog.enabled				true" >> ./conf/spark-defaults.conf
echo "spark.eventLog.dir				/home/spark/spark-events" >> ./conf/spark-defaults.conf
echo "spark.history.fs.logDirectory			/home/spark/spark-events" >> ./conf/spark-defaults.conf
echo "spark.sql.catalogImplementation			in-memory" >> ./conf/spark-defaults.conf

if ! COMPOSE_BAKE=true docker compose up -d --build; then
	echo "ERR!"
	exit 254
fi
exit 0;
