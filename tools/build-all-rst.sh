#!/bin/bash -e

mkdir -p publish-docs

doc-tools-build-rst security-guide --build build \
        --target security-guide
doc-tools-build-rst security-threat-analysis --build build \
        --target security-threat-analysis
