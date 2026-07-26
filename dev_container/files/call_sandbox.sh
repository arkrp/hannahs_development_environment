if [[ $(pwd) == "/home/dev/workspace/"* ]] || [ $(pwd) == "/home/dev/workspace" ]; then
   ssh dev@sandbox "cd $(pwd); $@"
else
   echo "sandbox only works inside the /home/dev/workspace directory."
   exit 1
fi
