#!/bin/bash

PUBCONFIG=$2
ROOTDIR=$1

# Determine the last changed files
mkdir -p "$ROOTDIR"
curl -o "$ROOTDIR/commit.json" https://raw.githubusercontent.com/ddvlanck/OSLO-StandaardenGenerated/master/commit.json
sleep 5s
jq . "$ROOTDIR/commit.json"
if [ $? -eq 0 ]; then
  PREV_COMMIT=$(jq -r .commit "$ROOTDIR/commit.json")
  changedFiles=$(git diff --name-only "$PREV_COMMIT")
  if [ "$changedFiles" == "standaardenregister.json" ]; then
    git show "$COMMIT:standaardenregister.json" > previous_version
    jq -s '.[0] - .[1]' standaardenregister.json previous_version >"$ROOTDIR/changedstandards.json"
    cat "$ROOTDIR/changedstandards.json"
    echo "One or more standards were modified"
  else
    cp "${PUBCONFIG}" "$ROOTDIR/changedstandards.json"
    echo "One or more files were changed, possibly a script, so a full rebuild is necessary"
  fi

else
  # No previous commit
  # Assumes full rebuild of all standards
  echo "No previous commit was made."
  echo "Processing all standards in standaardenregister.json"
  cp "$PUBCONFIG" "$ROOTDIR/changedstandards.json"
fi

#Process all standards that have been changed or were added
echo "Start processing the standards"
if cat "${PUBCONFIG}" | jq -e . >/dev/null 2>&1; then
  # only iterate over those that have a repository
  for row in $(jq -r '.[] | select(.repository)  | @base64 ' "${PUBCONFIG}"); do
    _jq() {
      echo "${row}" | base64 --decode | jq -r "${1}"
    }

    # Get name of repository to create a directory with the same name
    REPOSITORY=$(_jq '.repository')
    STATUS=$(_jq '.status')
    CONFIG=$(_jq '.configuration')
    THEME_NAME=$(echo "$REPOSITORY" | cut -d '/' -f 5)

    mkdir -p "$ROOTDIR/repositories/$THEME_NAME"

    echo "$THEME_NAME:$STATUS" >> "$ROOTDIR/status.txt"

    git clone "$REPOSITORY" "$ROOTDIR/repositories/$THEME_NAME"
    cd "$ROOTDIR/repositories/$THEME_NAME"
    git checkout standaardenregister

  done
else
  echo "Problem processing following file: ${PUBCONFIG}"
fi
