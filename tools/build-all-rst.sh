#!/bin/bash -e

mkdir -p publish-docs

doc-tools-build-rst security-guide --build build \
        --target security-guide
