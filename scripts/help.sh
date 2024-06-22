#! /usr/bin/env sh
set -euo pipefail

for file in $1; do
  grep -hE '^[a-zA-Z_-]+:.*?## .*$' "$file" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $1, $2}'
done
