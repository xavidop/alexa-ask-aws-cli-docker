#!/bin/sh -l

eval $1 > out.log
result=$(echo out.log)
echo "::set-output name=result::$result"