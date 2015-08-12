#!/bin/bash -e

mkdir -p publish-docs

tools/build-rst.sh security-guide --build build \
        --target security-guide
