#!/bin/bash -e

mkdir -p publish-docs

# This marker is needed for infra publishing
MARKER_TEXT="Project: $ZUUL_PROJECT Ref: $ZUUL_REFNAME Build: $ZUUL_UUID"

doc-tools-build-rst security-guide --build build \
        --target security-guide
echo $MARKER_TEXT > publish-docs/security-guide/.root-marker
doc-tools-build-rst security-threat-analysis --build build \
        --target security-threat-analysis
echo $MARKER_TEXT > publish-docs/security-threat-analysis/.root-marker
