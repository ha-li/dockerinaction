# to make a container read-only
MYSQL_CID=$(docker create -e MYSQL_ROOT_PASSWORD=ch2demo mysql:5)
docker start $MYSQL_CID

MAILER_CID=$(docker create dockerinaction/ch2_mailer)
docker start $MAILER_CID

if [ ! -n "$CLIENT_ID" ]; then
   echo "Client ID not set"
   exit 1
fi


# link wp to the db
WP_CID=$(docker create --link $MYSQL_CID:mysql --name wp_$CLIENT_ID -p 80 -v /run/lock/apache2/ -v /run/apache2/ -v /tmp/ -e WORDPRESS_DB_NAME=$CLIENT_ID --read-only wordpress:4)
docker start $WP_CID


# to inspect the state of the running if this outputs true, the 
# container is running, otherwise it is not 
#docker inspect --format "{{.State.Running}}" wp
