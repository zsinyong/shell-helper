#!/bin/bash

if[ ! -f env.sh ];then
    echo "Package error env.sh is missing,check the package!"
fi

if[ ! -f setup.sh];then
    echo "Package Fatal error setup.sh is missing!"
if