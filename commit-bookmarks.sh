#!/bin/bash

BOOKMARKS_REPO=${HOME}/toolkit/buku-bookmarks/

buku -e ${BOOKMARKS_REPO}/bookmarks-candidate.md
if [ ! -z "$(diff ${BOOKMARKS_REPO}/bookmarks-candidate.md ${BOOKMARKS_REPO}/bookmarks.md)" ]; then
	mv ${BOOKMARKS_REPO}/bookmarks-candidate.md ${BOOKMARKS_REPO}/bookmarks.md
	git -C ${BOOKMARKS_REPO} add ${BOOKMARKS_REPO}/bookmarks.md
	git -C ${BOOKMARKS_REPO} commit -m "bookmarks: Auto update"
	sed -ni '/### Auto-generated list/q;p' ${BOOKMARKS_REPO}/README.md
	echo -e "### Auto-generated list\n" >> ${BOOKMARKS_REPO}/README.md
	cat ${BOOKMARKS_REPO}/bookmarks.md >> ${BOOKMARKS_REPO}/README.md
fi

rm -f ${BOOKMARKS_REPO}/bookmarks-candidate.md
