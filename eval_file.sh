#!/bin/bash

while read -r line; do
    eval echo "$line" >>"$2"
done <"$1"
