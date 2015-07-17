#!/bin/bash -e

mkdir -p publish-docs

tools/build-rst.sh security-guide-rst --build build \
        --target draft/security-guide-rst
