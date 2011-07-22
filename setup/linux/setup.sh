#!/bin/bash
#
# $Id$
# 
# Prefiniti Setup Script for Linux
#  Copyright (C) 2011 Prefiniti, Inc.
#
#

function extract_archive {
    echo "Extracting installation files..."
    mv prefiniti-linux-files.tar.gz /opt
    pushd /opt
    gunzip prefiniti-linux-files.tar.gz
    tar xvf prefiniti-linux-files.tar
    popd
    echo "Done."
}      

function create_database {
    echo "Creating Prefiniti database..."
    pushd /opt/prefiniti-web
    mysql -u root -p$1 < sql/prefiniti-mysql-5.sql
    popd
    echo "Done."
}

function create_vhost {
    echo ""
}


if [ ${EUID} -ne 0 ] 
then
    echo "This script must be run as root."
    exit
fi

echo "Prefiniti Setup"
echo " Copright (C) 2011 Prefiniti, Inc."
echo ""
echo ""
echo "This script will create databases in MySQL and modify your Apache"
echo "configuration to support Prefiniti."
echo ""

read -p "Enter the root password for MySQL:  " MYSQLROOT
read -p "Enter the domain name of this machine (such as mydomain.com):  " DOMAINNAME

FQDN=`hostname`.${DOMAINNAME}

extract_archive
create_database ${MYSQLROOT}













