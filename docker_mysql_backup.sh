#!/bin/bash

################################################################
##
##   MySQL Database Backup Script
##   Last Update: March 20, 2020
##
################################################################

export PATH=/bin:/usr/bin:/usr/local/bin
TODAY=$(date +"%Y%m%d")
TIME=$(date +"%H%M")

################################################################
################## Update below values  ########################

DB_BACKUP_PATH='/home/user/dumps/'
MYSQL_CONTAINER='container_name'
MYSQL_HOST='localhost'
MYSQL_PORT='3306'
MYSQL_USER='root'
MYSQL_PASSWORD='your_super_secret_password'
DATABASE_NAME='db_name'
BACKUP_RETAIN_DAYS=3   ## Number of days to keep local backup copy

#################################################################
if [ ! -d ${DB_BACKUP_PATH}/"${TODAY}" ]; then
    mkdir -p ${DB_BACKUP_PATH}/"${TODAY}"
fi

echo "Backup started for database - ${DATABASE_NAME}"

docker exec "${MYSQL_CONTAINER}" mysqldump -h ${MYSQL_HOST} \
   -P ${MYSQL_PORT} \
   -u ${MYSQL_USER} \
   -p${MYSQL_PASSWORD} \
   ${DATABASE_NAME} | gzip > ${DB_BACKUP_PATH}/${TODAY}/${DATABASE_NAME}-${TODAY}_${TIME}.sql.gz

# $? is the exit status of the most recentllsy-executed command; by convention,
# 0 means success and anything else indicates failure.
# That line is testing whether the Docker Exec command succeeded.
if [ $? -eq 0 ]; then
  echo "Database backup successfully completed"
else
  echo "Error found during backup"
  exit 1
fi


##### Remove backups older than {BACKUP_RETAIN_DAYS} days  #####

DBDELDATE=`date +"%Y%m%d" --date="${BACKUP_RETAIN_DAYS} days ago"`

if [ ! -z ${DB_BACKUP_PATH} ]; then
      cd ${DB_BACKUP_PATH}
      if [ ! -z ${DBDELDATE} ] && [ -d ${DBDELDATE} ]; then
            rm -rf ${DBDELDATE}
      fi
fi

### End of script ####