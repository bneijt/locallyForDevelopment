#!/bin/sh

#Default is python 3
exec python -m http.server 4000

#Other option is python 2
exec python -m SimpleHTTPServer 4000

