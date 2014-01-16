#!/bin/bash

rm -rf target/site/reference
rm -rf target/site/pdf

mkdir -p target/site/reference
mkdir -p target/site/pdf

# this relies on the example project being build prior to this and is achieved
# with a separate build step
cp examples/target/mvnref-book-examples-1.0-SNAPSHOT-project.zip target/site/mvnref-examples.zip

cp -r target/book-mvnref.chunked/* target/site/reference

cp -r site/css target/site/reference
cp -r site/assets target/site/reference
cp -r site/js target/site/reference
cp -r site/images target/site/reference

cp target/book-mvnref.pdf target/site/pdf/mvnref-pdf.pdf

python template.py
cp target/site/reference/index.html target/site/reference/public-book.html
rsync -e ssh --delete -av target/site/ deployer@marketing01.int.sonatype.com:/var/www/domains/sonatype.com/www/shared/books/mvnref-book/
