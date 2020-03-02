
ROOTDIR=$1
REPODIR=$ROOTDIR/repositories

mkdir -p "$ROOTDIR/descriptions"

### Iterate over all repositories in /repositories
for REPO in $(find "$REPODIR" -maxdepth 1 -mindepth 1 -type d)
do
  # Get OSLOtheme name
  THEME_NAME=$(echo "$REPO" | cut -d "/" -f 5 | cut -d "-" -f 2)

  # The name of the configuration file contains information about the standard (if it's a voc or ap)
  CONFIG_NAME=$( cat "$ROOTDIR/configuration.txt" | grep "$THEME_NAME" | cut -d ":" -f 2 | cut -d "." -f 1)
  cd "$REPO"
  if test -f "README.md" ; then
    node /app/index.js -f README.md -o "$ROOTDIR/descriptions/$CONFIG_NAME-description.html"
  fi
done
