#!/bin/bash

echo "✔️ 배포 시작"

# 현재 시간 기준 태그 생성 (yyMMddHHmm)
TAG_NAME=$(date +"%y%m%d%H%M")
SOURCE_PATH="/home/ubuntu/highlighter-demo.api"

echo "✔️ Git Pull"
cd /home/ubuntu/highlighter-demo.deploy
git pull origin master

echo "✔️ Docker Build & Push"
docker build --tag keyy1315/highlighter-demo.api:dev-latest \
             --tag keyy1315/highlighter-demo.api:$TAG_NAME \
             "$SOURCE_PATH"

docker push keyy1315/highlighter-demo.api:dev-latest
docker push keyy1315/highlighter-demo.api:$TAG_NAME

echo "✔️ Docker Compose 재시작"
cd /home/ubuntu/highlighter-demo.deploy
docker-compose down
docker-compose up -d --build
