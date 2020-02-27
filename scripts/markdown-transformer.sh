
ROOTDIR=$1
REPODIR=$ROOTDIR/repositories

mkdir -p "$ROOTDIR/descriptions"

for REPO in $(find "$REPODIR" -maxdepth 1 -mindepth 1 -type d)
do
  THEME_NAME=$(echo "$REPO" | cut -d "/" -f 5 | cut -d "-" -f 2)
  cd $REPO
  if test -f "README.md" ; then
    node /app/index.js -f README.md -o "$ROOTDIR/descriptions/$THEME_NAME-description.html"
  fi
done