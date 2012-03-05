#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <template-name>"
	echo "Compiles .ctpp2 to .ct2" 
    exit -1
fi

TEMPLATE=$1
ctpp2c ${TEMPLATE}.ctpp2 ${TEMPLATE}.ct2
