requires(){
  [[ -e "$(which $1)" ]] || (echo "ERROR $1 is required" && exit 1)
}
