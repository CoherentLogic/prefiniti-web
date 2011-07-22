#!/bin/bash
#
# $Id$
#

DISTRIBUTION=$1
PLATFORM=$2

echo "::: PREFINITI DISTRIBUTION BUILDER :::"
echo " DISTRIBUTION DIRECTORY:  ${DISTRIBUTION}"
echo " DISTRIBUTION PLATFORM:   ${PLATFORM}"
echo ""
echo ""
echo "CREATING DISTRIBUTION DIRECTORY..."
mkdir ${DISTRIBUTION}
cd ${DISTRIBUTION}
echo "FETCHING PREFINITI FROM REPOSITORY..."
svn checkout http://prefiniti-web.googlecode.com/svn/trunk/ prefiniti-web-read-only > /dev/null
mv prefiniti-web-read-only prefiniti-web
echo "GETTING THE SETUP SCRIPT..."
mv prefiniti-web/setup/${PLATFORM}/setup.sh .
echo "NORMALIZING DISTRIBUTION..."
rm -Rf setup
echo "BUILDING FILES ARCHIVE..."
tar cvf prefiniti-${PLATFORM}-files.tar prefiniti-web/ > /dev/null
gzip prefiniti-${PLATFORM}-files.tar
echo "BUILDING FULL ARCHIVE..."
tar cvf prefiniti-${PLATFORM}.tar prefiniti-${PLATFORM}-files.tar.gz setup.sh > /dev/null
gzip prefiniti-${PLATFORM}.tar
rm -Rf prefiniti-web
echo "DONE."

