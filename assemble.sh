#!/bin/bash

html=target/site/reference
pdf=target/site/pdf

rm -rf $html
rm -rf $pdf

mkdir -p target/site/reference
mkdir -p target/site/pdf

# this relies on the example project being build prior to this and is achieved
# with a separate build step
cp examples/target/mvnref-book-examples-1.0-SNAPSHOT-project.zip target/site/mvnref-examples.zip

cp -r target/book-mvnref.chunked/* $html
cp target/book-mvnref.pdf $pdf/mvnref-pdf.pdf

echo "Invoking templating process"
../documentation-wrapper/apply-template.sh ../maven-reference-en/$html "Maven: The Complete Reference" "017156762307045728421:e5xgzsj0rjw"

cp $html/index.html $html/public-book.html
