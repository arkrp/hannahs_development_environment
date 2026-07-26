#!/bin/bash
# This program opens a github flavored markdown for viewing with zathura
bash /app/call_sandbox.sh pandoc -f gfm -t pdf $1 | zathura -
