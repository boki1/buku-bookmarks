#!/bin/bash

pushd ${BOOKMARKS_REPO}

buku -e bookmarks-candidate.md
if [ ! -z "$(diff bookmarks-candidate.md bookmarks.md)" ]; then
	mv bookmarks-candidate.md bookmarks.md
	sed -ni '/### Auto-generated list/q;p' README.md
	echo -e "### Auto-generated list\n" >> README.md
	cat bookmarks.md >> README.md
	git add bookmarks.md README.md
	git commit -m "bookmarks: Auto update" --author="Commit Bot <commitbot>"
fi

rm -f bookmarks-candidate.md
popd
