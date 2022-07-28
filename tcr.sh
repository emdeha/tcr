#!/bin/bash

function test() {
  echo "Testing changes..."
  php bin/phpunit && composer phpstan && composer phpcs
}

function commit() {
  echo "Committing changes"
  git add . && git commit -m "WIP"
}

function revert() {
  echo "Reverting changes"
  git checkout .
}

fswatch -1 -o -r src | while read; do
  git diff --quiet || ( test && commit || revert )
done
