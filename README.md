Docker MySQL Backup
===
Bash script that performance a MySQL Backup of a database running in a Docker container.
## Instructions
* clone or download the project locally
  * ```python git clone git@github.com:JavierMacro/Docker-MySQL-Backup.git```
* Enter the project directory and update update the following variable in *docker_mysql_backup.sh*, according to your system:
	* DB_BACKUP_PATH : Where are you going to save your backups
	* MYSQL_CONTAINER: Name of the Docker container that has the MySQL server and database
	* MYSQL_HOST: Mysql host in the Docker container, usually 'localhost'
	* MYSQL_PORT: Port used for the mysql container to connect with the outside world, usually '3306'
	* MYSQL_USER: An user with privileges to yse mysqldump, I use 'root'
	* MYSQL_PASSWORD: The password fo that user
	* DATABASE_NAME: What database are we going to backup
	* BACKUP_RETAIN_DAYS:  Number of days to keep local backup copy
* Run
	*  ```sh docker_mysql_backup.sh```
## License
With MIT open source license
