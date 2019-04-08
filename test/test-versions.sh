!/usr/bin/env bash

set -e

GIT_TEST_VERSIONS=${GIT_TEST_VERSIONS:-CURRENT}
TESTS=${TESTS:-$(echo scripts/[0-9]*)}

success=0
failure=0
for ver in $GIT_TEST_VERSIONS; do
    docker build -t git-overhere-test:${ver} ..
    for test in $TESTS; do
        if docker run -i --rm \
                  --name git-overhere-test \
                  -v $(readlink -f scripts/):/scripts:ro \
                  -w / \
                  git-overhere-test:${ver} \
                  "${test}"; then
           echo ">>> Test '${test}' of git-overhere against git ${ver} ::SUCCESS::"
           success=$((success + 1))
        else
           echo ">>> Test '${test}' of git-overhere against git ${ver} ::FAILURE::"
           failure=$((failure + 1))
        fi
    done
done

echo "Total tests: $((success + failure))"
echo "Successful tests: $success"
echo "Failing tests: $failure"

if [[ "$failure" -gt "0" ]]; then
  exit 1
fi
