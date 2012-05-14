import airspeed
import glob
import os

t = airspeed.Template(open("site/book-template.html", "r").read())
bookTitle = "Maven: The Complete Reference"
bookId = "mvnrefbook"
 
path = 'target/site/reference'
for infile in glob.glob( os.path.join(path, '*.html') ):
  print "Reading File: " + infile
  body = open(infile, "r").read()
  title = body[ body.index( "<title>" ) + 7 : body.rindex("</title>") ]

  if title == "Maven: The Complete Reference":
    title = "Table of Contents"

  body = body[ body.index( "<body>") + 6 : body.rindex("</body>") ]
  
  open(infile, "w").write( t.merge(locals()) );
