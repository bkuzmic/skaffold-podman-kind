#!/usr/bin/env bash
set -Eefuo pipefail

dockerImageNoTag="${IMAGE%:*}"

podman build --tag="$IMAGE" --cache-from="$dockerImageNoTag" "${BUILD_CONTEXT:-.}"

if [[ "${PUSH_IMAGE}" == "true" ]]; then
    echo "Pushing $IMAGE"
    podman push "$IMAGE"
else
    echo "Not pushing $IMAGE"
fi