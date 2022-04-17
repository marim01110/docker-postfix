#!/bin/sh
docker buildx build --platform linux/amd64,linux/arm64 -t marimo1110/postfix:20220417 --no-cache --push .
docker buildx build --platform linux/amd64,linux/arm64 -t marimo1110/postfix:latest --push .
