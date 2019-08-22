#!/bin/bash -e

mkdir -p publish-docs/html

# This marker is needed for infra publishing
MARKER_TEXT="Project: $ZUUL_PROJECT Ref: $ZUUL_REFNAME Build: $ZUUL_UUID Revision: $ZUUL_NEWREV"

doc-tools-build-rst security-guide --build build \
                    --target security-guide
echo $MARKER_TEXT > publish-docs/html/security-guide/.root-marker
doc-tools-build-rst security-threat-analysis --build build \
        --target security-threat-analysis
echo $MARKER_TEXT > publish-docs/html/security-threat-analysis/.root-marker
