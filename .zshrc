# Commit reminder

alias gcm='{ 
  read -q "REPLY? Do you done tested it manually? [y/N]: ";
  echo;
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then 
    echo "Remember to test it manually!"; 
    return 1; 
  fi;
  read -q "REPLY? Do you done tested it using unit test? [y/N]: "; 
  echo; 
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then 
    echo "Remember to test it using unit test!"; 
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
