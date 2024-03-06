# Commit reminder

alias gcm='{ 
  read -q "REPLY? Do you done tested it Manually? [y/N]: "; 
  echo; 
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then 
    echo "Remember to test manually!"; 
    make test -C $(pwd); 
    return 1; 
  fi; 
  read -q "REPLY? Do you want to proceed with the commit? [y/N]: "; 
  echo; 
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then 
    echo "Commit aborted!"; 
    return 1; 
  fi; 
  git commit; 
}'
