#!/bin/bash

function delete_uncommitted_changes() {
  echo "Deleting uncommitted changes ...."
  git reset --hard
  git clean -fd

  echo "checkout to main/master branch"
  if git show-ref --verify --quiet refs/heads/main; then
    git checkout main
  elif git show-ref --verify --quiet refs/heads/master; then
    git checkout master
  else
    echo "no main oder master branch change, skip Repo."
    return
  fi
}

function clean_repo() {
  # get all local branches with name "feature/"
  branches=$(git for-each-ref --format='%(refname:short) %(committerdate:unix)' refs/heads/feature/*)
  if [ -z "$branches" ]; then
    echo "No branches with name 'feature/' found"
    return
  fi
  # calculate 14 days ago
  now=$(date +%s)
  cutoff=$((now - 14*24*3600))

  echo "Deleting local feature branches older than 14 days ..."
  while read -r line; do
    branch=$(echo "$line" | cut -d' ' -f1)
    commit_date=$(echo "$line" | cut -d' ' -f2)
    echo "Checking $branch"
    if [ "$commit_date" -lt "$cutoff" ]; then
      echo "Remove branch $branch (last commit before $(date -d @$commit_date))"
      git branch -D "$branch"
    else
      echo " Keep branch $branch (last commit before $(date -d @$commit_date)"
    fi
  done <<< "$branches"
}

for dir in */; do
  if [ -d "$dir/.git" ]; then
    cd "$dir" || exit
    echo "Cleanup repository $dir"
    delete_uncommitted_changes
    clean_repo
    cd ..
  fi
done
