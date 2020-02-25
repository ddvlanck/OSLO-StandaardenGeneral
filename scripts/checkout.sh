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
   if [ "$listofchanges" == "config/publication.json" ] ; then
       git show $COMMIT:config/publication.json > prev
       jq -s '.[0] - .[1]' config/publication.json prev > $ROOTDIR/changedpublications.json
       cat $ROOTDIR/changedpublications.json
       echo "true" > $ROOTDIR/haschangedpublications.json
       cp ${PUBCONFIG} $ROOTDIR/publications.json.old
#       echo "false" > $ROOTDIR/haschangedpublications.json
       cp $ROOTDIR/changedpublications.json ${PUBCONFIG}

   else
       cp ${PUBCONFIG} $ROOTDIR/changedpublications.json
       echo "false" > $ROOTDIR/haschangedpublications.json
       echo "process all publication points";
   fi

else
   # No previous commit
   # Assumes full rebuild of all standards
   echo "No previous commit was made."
   echo "Processing all standards in standaardenregister.json"
   cp "$PUBCONFIG" "$ROOTDIR/changedstandards.json"
fi
