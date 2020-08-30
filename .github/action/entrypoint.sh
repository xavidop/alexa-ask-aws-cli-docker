#!/bin/sh -l

result=$(eval $1)
echo "::set-output name=result::$result"