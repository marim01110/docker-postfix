#!/bin/bash
docker buildx build --platform linux/amd64,linux/arm64 -t marimo1110/postfix:20220408 --push .
