mytarget="$1"
substring=".jar"
if [[ $# -eq 1 ]]; then
  for mystring in $(find ./ -print)
  do
    if [[ "$mystring" =~ "$substring" ]]; then
      echo "searching jar > $mystring"
      results=$(jar -tvf "$mystring" | grep "$mytarget")
      if [[ ! "$results" =~ [^[:space:]] ]]; then
        results="   $mytarget not found in $mystring"
      else
        results="   Found target\n$results"
      fi
      echo -e "Search results for $mystring:"
      echo -e "$results"
    else
      if [[ "$mystring" =~ "$mytarget" ]]; then
      echo "found file in location > $mystring"
      fi
    fi
  done
else
  echo "You must provide only one name to search. If search with name with space place name in quotes."
fi

