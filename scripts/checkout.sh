#!/bin/bash

PUBCONFIG=$2
ROOTDIR=$1


# determin the last changed files
mkdir -p $ROOTDIR
curl -o $ROOTDIR/commit.json https://raw.githubusercontent.com/ddvlanck/OSLO-StandaardenGenerated/master/report/commit.json
sleep 5s
jq . "$ROOTDIR/commit.json"
if  [ $? -eq 0 ] ; then
   COMMIT=`jq -r .commit $ROOTDIR/commit.json`
   listofchanges=$(git diff --name-only $COMMIT)
   echo $listofchanges > changes.txt

else
   # no previous commit
   # assumes full rebuild
   echo "No previous commit was made."
   echo "Processing all standards in standaardenregister.json"
   cp "$PUBCONFIG" "$ROOTDIR/changedstandards.json"
fi
