#!/bin/bash

mkdir -p target/site/reference
mkdir -p target/site/pdf
cp -r target/book-mvnref.chunked/* target/site/reference
cp target/book-mvnref.pdf target/site/pdf/mvnref-pdf.pdf
python template.py
cp target/site/reference/index.html target/site/reference/public-book.html
rsync -e ssh -av target/site/* deployer@www.sonatype.com:/var/www/domains/sonatype.com/www/shared/books/mvnref-book/
