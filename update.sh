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

git rm -rf -- doc
(cd $doc; make clean; make)
cp -R $doc/output/html doc
git add -- doc
(cd $doc; make clean)

echo
echo "New docs generated"
echo
git status
