#!/bin/bash

# 사용법: ./split-large-file.sh [입력파일] [청크크기]
# 예시: ./split-large-file.sh input.txt 1000

if [ $# -ne 2 ]; then
    echo "사용법: $0 [입력파일] [청크크기]"
    exit 1
fi

INPUT_FILE=$1
CHUNK_SIZE=$2

if [ ! -f "$INPUT_FILE" ]; then
    echo "오류: 파일 '$INPUT_FILE'을 찾을 수 없습니다."
    exit 1
fi

# 입력 파일의 디렉토리, 이름, 확장자 분리
DIR=$(dirname "$INPUT_FILE")
FILENAME=$(basename "$INPUT_FILE")
NAME="${FILENAME%.*}"
EXT="${FILENAME##*.}"
CHUNK_DIR="${DIR}/${NAME}_chunks"

# 청크 디렉토리 생성 또는 정리
if [ -d "$CHUNK_DIR" ]; then
    echo "기존 청크 디렉토리 정리 중..."
    rm -rf "${CHUNK_DIR}"/*
else
    echo "청크 디렉토리 생성 중..."
    mkdir -p "$CHUNK_DIR"
fi

# 파일을 청크 단위로 분할
split -l "$CHUNK_SIZE" "$INPUT_FILE" "${CHUNK_DIR}/chunk_"

# 확장자 변경
for chunk_file in "${CHUNK_DIR}"/chunk_*; do
    mv "$chunk_file" "${chunk_file}.${EXT}"
done

echo "모든 청크 처리 완료"
echo "청크 파일들이 저장된 디렉토리: $CHUNK_DIR"
