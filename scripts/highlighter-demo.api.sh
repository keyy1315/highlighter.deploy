#!/bin/bash

SOURCE_PATH=$1
TAG_NAME=${2:-$(date +%y%m%d%H%M)}  # 기본값: 현재 날짜 시각 (yyMMddHHmm)

if [ -z "$TAG_NAME" ]; then
  echo "❌ TAG_NAME이 비어있습니다. 유효한 태그를 입력하세요."
  exit 1
fi

echo "🛠️ Building Docker image with tag: $TAG_NAME"

docker build --tag keyy1315/highlighter-demo.api:dev-latest --tag keyy1315/highlighter-demo.api:$TAG_NAME "$SOURCE_PATH"

docker push keyy1315/highlighter-demo.api:dev-latest
docker push keyy1315/highlighter-demo.api:$TAG_NAME
