#!/bin/bash

INPUT=$1
OUTPUT=$2

echo "" > $OUTPUT
cat modules/dat/head.txt >> $OUTPUT
rm modules/dat/head.txt
pandoc -f markdown -t latex $INPUT >> $OUTPUT
echo "\\end{document}" >> $OUTPUT
