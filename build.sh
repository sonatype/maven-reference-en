#!/bin/bash

mkdir -p target/images
mkdir -p target/figs

# Build the Single HTML Page Version
asciidoc -o target/book-mvnref.html -a gitrevision=`git describe --dirty` book-mvnref.asciidoc 

# Build the PDF
rm -rf target/images
rm -rf target/figs
rm -rf target/promo_*.*
cp -r figs target
cp -r images target
cp -r promos/* target

a2x -v -k -fpdf -dbook --dblatex-opts=" -P doc.publisher.show=0 -P latex.output.revhistory=0  -s ./latex/custom-docbook.sty" -a gitrevision=`git describe --dirty` -D target book-mvnref.asciidoc

# Build the Chunked HTML
a2x -v -k -fchunked --xsl-file=docbook-xsl/custom-chunked.xsl \
    --xsltproc-opts "--stringparam chunk.section.depth 1 --stringparam toc.section.depth 2" \
    -dbook \
    --dblatex-opts=" -P doc.publisher.show=0 -P latex.output.revhistory=0" \
    -a gitrevision=`git describe --dirty` \
    -D target book-mvnref.asciidoc
