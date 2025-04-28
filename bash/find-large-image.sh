#!/bin/bash

# 사용법: ./find-large-image.sh [디렉토리 경로]
# 디렉토리 경로가 지정되지 않은 경우 현재 디렉토리를 사용
TARGET_DIR=${1:-.}

# 파일 크기 제한 (100KB = 102,400 바이트)
SIZE_LIMIT=102400

echo "검색 시작: $TARGET_DIR (하위 디렉토리 포함)"
echo "크기 제한: 100KB 이상"
echo "검색 파일: jpg, jpeg"

# find 명령어로 jpg/jpeg 파일을 찾고 크기를 확인
find "$TARGET_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" \) -size +${SIZE_LIMIT}c -exec ls -lh {} \; | while read -r line; do
    echo "$line"
done

echo "검색 완료"
