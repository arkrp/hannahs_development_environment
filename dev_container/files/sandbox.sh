#!/bin/bash
if [[ $(pwd) == "/home/dev/workspace/"* ]] || [ $(pwd) == "/home/dev/workspace" ]; then
   ssh -t -q dev@sandbox "cd $(pwd); $@"
   exit 0
else
   echo "sandbox only works inside the /home/dev/workspace directory." >&2
   exit 1
fi
