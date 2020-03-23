
ROOTDIR=$1
REPODIR=$ROOTDIR/repositories

mkdir -p "$ROOTDIR/descriptions"


while IFS= read -r line
do
  REPO_NAME=$(echo "$line" | cut -d ":" -f 1)

  cd "$REPODIR/$REPO_NAME"

  CONFIG_NAME=$(echo "$line" | cut -d ":" -f 2 | cut -d "." -f 1)
  if test -f "README.md" ; then
    node /app/index.js -f README.md -o "$ROOTDIR/descriptions/$CONFIG_NAME-description.html"
  fi
done < "$ROOTDIR/tmp-register.txt"
