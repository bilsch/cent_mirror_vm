#!/bin/sh

MIRROR_DIR=${MIRROR_DIR:-/var/www/html/mirrors} 
# if you want to pass any special args - man reposync
REPOSYNC_ARGS=${REPOSYNC_ARGS:-"-q --download-metadata --downloadcomps"}

set -e
cd $MIRROR_DIR
reposync ${REPOSYNC_ARGS}

# based on https://gist.github.com/brianredbeard/7034245
for dir in $(find . -maxdepth 1 -type d ! -name '.')
do
  if [ -f "$dir/comps.xml" ];
  then
    cp $dir/comps.xml $dir/Packages
    createrepo --update -p --workers 2 -g Packages/comps.xml $dir
  else
    createrepo --update -p --workers 2 $dir
  fi
    
  if [ -f $dir/*-updateinfo.xml.gz ];
  then
    gzip -d $dir/*-updateinfo.xml.gz
    modifyrepo $dir/*-updateinfo.xml
  fi
done
