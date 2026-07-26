if [[ $(pwd) == "/home/dev/workspace/"* ]] || [ $(pwd) == "/home/dev/workspace" ]; then
   ssh -t -X dev@sandbox "cd $(pwd); bash"
else
   echo "sandbox only works inside the /home/dev/workspace directory."
fi
