if [[ $1 == "-t" ]]; then
   if [[ $(pwd) == "/home/dev/workspace/"* ]] || [ $(pwd) == "/home/dev/workspace" ]; then
      shift 1
      ssh -t dev@sandbox "cd $(pwd); bash -i -c \"$@\""
      exit 0
   else
      echo "sandbox only works inside the /home/dev/workspace directory."
      exit 1
   fi
else
   if [[ $(pwd) == "/home/dev/workspace/"* ]] || [ $(pwd) == "/home/dev/workspace" ]; then
      ssh dev@sandbox "cd $(pwd); $@"
   else
      echo "sandbox only works inside the /home/dev/workspace directory."
      exit 1
   fi
fi
