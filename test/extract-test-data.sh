#!/bin/bash
#
set -x
set -e

hovedenheter="$1"
underenheter="$2"
hovedenheterTestdata="hovedenheter-testdata.json"
generateUnderenheterJqfilter="generate-underenheter.jqfilter"
generatedUnderenheterJqfilter="generated-underenheter.jqfilter"
underenheterTestdata="underenheter-testdata.json"

if test "clean" = "$3"; then
  rm "$hovedenheterTestdata"
  rm "$underenheterTestdata"
  rm "$generatedUnderenheterJqfilter"
fi

if test \! -f "$hovedenheter" -o \! -f "$underenheter"; then
    echo "Usage: extract-test-data.sh /path/to/hovedenheter.json /path/to/underenheter.json"
    exit 1
fi

if test \! -f "$hovedenheterTestdata"; then
  jq -f hovedenheter.jqfilter "$hovedenheter" > "$hovedenheterTestdata"
fi
if test \! -f "$generatedUnderenheterJqfilter"; then
  jq -r -f "$generateUnderenheterJqfilter" "$hovedenheterTestdata" > "$generatedUnderenheterJqfilter"
fi
if test \! -f "$underenheterTestdata"; then
  jq -f "$generatedUnderenheterJqfilter" "$underenheter" > "$underenheterTestdata"
fi