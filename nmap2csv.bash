#!/usr/bin/env bash
#
# $Id: nmap2csv.bash,v 1.1 2013/05/01 21:08:16 decal Exp $
#
# Script for: Extracting DNS hostnames and numeric IP addresses from default
# NMap (port scanner) output for live hosts and writen them to a CSV file.
#
# Written by: Derek Callaway <decal [at] ethernet [dot] org>
#
# Testing on: GNU bash, version 4.2.0(1)-release (x86_64--netbsd)
#
# References: http://insecure.org/nmap
#
################################################################################

if [ ! $1 ];
  then echo "usage: $0 INPUT"
  echo      "  INPUT  path to input file (typical nmap text output)"

  exit -1
fi

egrep -iB1 '^host is up' $1 |grep -i '^nmap scan report for ' |\
  awk '{print $5 " " $6}' | tr -d ')' | sed 's! (!,!g' |\
  awk -F, '{print($2 "," $1);}' | sed -r 's|^[,]+||g'

exit 0
