# Assuming that you are working a go project and you want to check the project before committing the changes
alias check-project='{
  # Check if the current directory is in the project directory
  if [ ! -d "/Users/user/Documents/github.com/project" ]; then
    echo "You are not in the project directory!";
    return 1;
  fi;

  # Check unit test
  go test ./...;
  if [ $? -ne 0 ]; then
    echo "Test failed!";
    return 1;
  fi;

  # Check lint
  golangci-lint run --fix;

  if [ $? -ne 0 ]; then
    echo "Lint failed!";
    return 1;
  fi;

  # Ready to commit
  echo "All good, ready to commit!";
}'

# Commit reminder
alias gcm='{ 
  # Prompt to test the changes manually
  read -q "REPLY? Do you done tested it manually? [y/N]: ";
  echo;
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then 
    echo "Remember to test it manually!"; 
    return 1; 
  fi;

  # Prompt to test the changes using unit test
  read -q "REPLY? Do you done tested it using unit test? [y/N]: "; 
  echo; 
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then 
    echo "Remember to test it using unit test!"; 
    make test -C $(pwd); 
    return 1; 
  fi; 

  # Prompt to proceed with the commit
  read -q "REPLY? Do you want to proceed with the commit? [y/N]: "; 
  echo; 
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then 
    echo "Commit aborted!"; 
    return 1; 
  fi; 

  # If all the prompts are passed, then proceed with the commit
  git commit; 
}'

# Push reminder
alias gpl='{ 
  # Prompt to test the changes manually
  read -q "REPLY? Do you done tested it manually? [y/N]: ";
  echo;
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then 
    echo "Remember to test it manually!"; 
    return 1; 
  fi;

  # Prompt to test the changes using unit test
  read -q "REPLY? Do you done tested it using unit test? [y/N]: "; 
  echo; 
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then 
    echo "Remember to test it using unit test!"; 
    make test -C $(pwd); 
    return 1; 
  fi; 

  # Prompt to proceed with the push
  read -q "REPLY? Do you want to proceed with the push? [y/N]: "; 
  echo; 
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then 
    echo "Push aborted!"; 
    return 1; 
  fi; 

  # If all the prompts are passed, then proceed with the push
  git push; 
}'

# cherry-pick alias, an alias with a parameter
alias cherry-picker='f() { 
  if [ -z "$1" ]; then
    echo "Please provide the commit hash!";
    return 1;
  fi;

  git cherry-pick -m 1 $1;

  echo "Cherry-picking commit $1";
};f'