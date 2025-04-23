#!/bin/bash

set -euo pipefail

# -----------------------
# 환경변수 설정 (필요 시 Jenkins에서 넘겨줘야 함)
# -----------------------
API_REPO_URL="https://github.com/keyy1315/highL-demo.api.git"
IMAGE_NAME="keyy1315/highlighter-demo.api"

# -----------------------
# Docker 로그인
# -----------------------
if [[ -z "${DOCKERHUB_USERNAME:-}" || -z "${DOCKERHUB_PASSWORD:-}" ]]; then
  echo "❌ Docker Hub credentials not set. Set DOCKERHUB_USERNAME and DOCKERHUB_PASSWORD."
  exit 1
fi

echo "🔐 Logging into Docker Hub..."
echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin

# -----------------------
# 소스 클론 및 이미지 빌드
# -----------------------
echo "📦 Cloning API repo..."
rm -rf highL-demo.api
git clone "$API_REPO_URL"
cd highL-demo.api

echo "🔨 Building Docker image..."
docker build -t "$IMAGE_NAME:latest" .

echo "🚀 Pushing image to Docker Hub..."
docker push "$IMAGE_NAME:latest"

cd ..
rm -rf highL-demo.api

# -----------------------
# docker-compose 실행
# -----------------------
echo "♻️ Restarting application with docker-compose..."
docker compose down
docker compose pull
docker compose up -d

echo "✅ Deployment complete!"
