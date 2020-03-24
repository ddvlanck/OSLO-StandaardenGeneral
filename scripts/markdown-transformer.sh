
ROOTDIR=$1
REPODIR=$ROOTDIR/repositories

mkdir -p "$ROOTDIR/descriptions"


while IFS= read -r line
do
  REPO_NAME=$(echo "$line" | cut -d ":" -f 1)
  DESCRIPTION_NAME=$(echo "$line" | cut -d ":" -f 4)
  DESCRIPTION_PATH="beschrijvingen/$DESCRIPTION_NAME"

  cd "$REPODIR/$REPO_NAME"

  CONFIG_NAME=$(echo "$line" | cut -d ":" -f 2 | cut -d "." -f 1)
  if test -f "$DESCRIPTION_PATH" ; then
    echo "FOUND A DESRIPTION FOR $REPO_NAME"
    #node /app/index.js -f README.md -o "$ROOTDIR/descriptions/$CONFIG_NAME-description.html"
  fi
done < "$ROOTDIR/tmp-register.txt"
