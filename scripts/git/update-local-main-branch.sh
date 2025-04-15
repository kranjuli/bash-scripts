#!/bin/bash

for dir in */; do
  if [ -d "$dir/.git" ]; then
    echo "Pulling in $dir..."
    cd "$dir"
    git checkout main
    git pull origin main
    cd ..
  fi
done
