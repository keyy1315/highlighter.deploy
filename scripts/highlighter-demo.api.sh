
SOURCE_PATH=$1
TAG_NAME=$2

docker build --tag keyy1315/highlighter-demo.api:dev-latest --tag keyy1315/highlighter-demo.api:$TAG_NAME "$SOURCE_PATH"
docker push keyy1315/highlighter-demo.api:dev-latest
docker push keyy1315/highlighter-demo.api:$TAG_NAME
