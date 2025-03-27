#source .env.db
DB_CONTAINER_IMAGE="mongodb/mongodb-community-server"
DB_IMAGE_TAG="7.0.11-ubuntu2204"

ROOT_USER="root-user"
ROOT_PWD="root-password"

KEY_VALUE_DB="key-value-db"
KEY_VALUE_USER="key-value-user"
KEY_VALUE_PASSWORD="key-value-password"

#network
#source .env.network

#storage
#source .env.volume
VOLUME_CONTAINER_PATH="/data/db"

source setup.sh

if [ "$(docker ps -q -f name=$DB_CONTAINER_NAME)" ]; then
    echo "A container with the name $DB_CONTAINER_NAME already exists."
    echo "The container will be removed when stopped."
    echo "To stop the container, run: docker kill $DB_CONTAINER_NAME"
    exit 1
fi

docker run --rm --name $DB_CONTAINER_NAME -d \
-e MONGODB_INITDB_ROOT_USERNAME=$ROOT_USER \
-e MONGODB_INITDB_ROOT_PASSWORD=$ROOT_PWD \
-v "$(pwd)"/db-config/mongo-init.js:/docker-entrypoint-initdb.d/mongo-init.js:ro \
-e KEY_VALUE_DB=$KEY_VALUE_DB \
-e KEY_VALUE_USER=$KEY_VALUE_USER \
-e KEY_VALUE_PASSWORD=$KEY_VALUE_PASSWORD \
-p 27001:27001 \
-v $VOLUME_NAME:$VOLUME_CONTAINER_PATH \
--network $NETWORK_NAME \
$DB_CONTAINER_IMAGE:$DB_IMAGE_TAG



