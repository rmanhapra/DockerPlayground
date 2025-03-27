#DB
source .env.db
echo $KEY_VALUE_USER


#network
source .env.network

BACKEND_CONTAINER_NAME="backendserver"
BACKEND_IMAGE_NAME="key-value-backendserver"
MONGODB_HOST="mongodb"

if [ "$(docker ps -aq -f name=$BACKEND_CONTAINER_NAME)" ]; then
    echo "A container with the name $BACKEND_CONTAINER_NAME already exists."
    echo "The container will be removed when stopped."
    echo "To stop the container, run: docker kill $BACKEND_CONTAINER_NAME"
    exit 1
fi

docker build -f backendserver/Dockerfile.dev -t $BACKEND_IMAGE_NAME backendserver

docker run --rm --name $BACKEND_CONTAINER_NAME -d \
-e KEY_VALUE_DB=$KEY_VALUE_DB \
-e KEY_VALUE_USER=$KEY_VALUE_USER \
-e KEY_VALUE_PASSWORD=$KEY_VALUE_PASSWORD \
-e PORT=3000 \
-e MONGODB_HOST=$MONGODB_HOST \
-p 3000:3000 \
-v "$(pwd)"/backendserver/src:/app/src \
--network $NETWORK_NAME \
$BACKEND_IMAGE_NAME



