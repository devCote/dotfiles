# bash shell functions 

function commit() {
  git add -A; 
  git commit -m $1;
  if [ -z "$2" ]; then
    git push origin master
  else
    git push origin $2
  fi
}

function tsm-log() {
    while [ true ]; do
      tsm -l
      sleep 1
      clear
    done
}
