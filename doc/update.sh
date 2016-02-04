#!/usr/bin/env bash

set -e

cd $(dirname $0)

doc=${doc:-~/src/spdk/doc}

if [ ! -d $doc ]; then
        echo "$doc: directory doesn't exist"
        echo "Specify doc path with:"
        echo "  doc=/dir/to/spdk/doc $0"
        exit 1
fi

dirs=$(cd $doc; echo Doxyfile.* | sed -e 's/Doxyfile.//g')

git rm -rf -- $dirs
(cd $doc; make clean; make)
for d in $dirs; do
        cp -R $doc/output.$d/html $d
done
git add -- $dirs
(cd $doc; make clean)

echo
echo "New docs generated"
echo
git status
