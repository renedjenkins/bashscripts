# bashscripts
Collection of bashscripts
Script:
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

Create a bash file just a "*.sh" file.  Copy the above into that file.  Whatever directory you place this script into it will recursively search the host directory.  This is specific to search for jars, which is why I hard coded the .jar extension.  It could be modified for zips or other types of archives.  You must provide a search string but only one command line argument.  If for some reason it contains a space in the name then wrap the argument in quotes.  Example:
bash testsearch.sh "Simple Test"

This is my example directory:
rjenkins@webserver:~/testsearch$ ll -R
.:
total 20
-rwxrw-r-- 1 rjenkins rjenkins  318 Jan  7 17:30 mysearch.sh*
-rwxr--r-- 1 rjenkins rjenkins 1424 Jan  7 16:08 mytestclass.jar*
-rwxr--r-- 1 rjenkins rjenkins 1543 Jan  7 16:08 simpletest.jar*
drwxrwxr-x 3 rjenkins rjenkins 4096 Jan  7 16:15 test01/
-rwxrw-r-- 1 rjenkins rjenkins  718 Jan  7 18:39 testsearch.sh*

./test01:
total 4
-rw-rw-r-- 1 rjenkins rjenkins    0 Jan  7 16:15 test01.txt
drwxrwxr-x 2 rjenkins rjenkins 4096 Jan  7 17:29 test02/

./test01/test02:
total 0
-rw-rw-r-- 1 rjenkins rjenkins 0 Jan  7 17:29 SimpleTest.txt
-rw-rw-r-- 1 rjenkins rjenkins 0 Jan  7 16:16 test02.txt

Here is an example run:
rjenkins@webserver:~/testsearch$ bash testsearch.sh SimpleTest
searching jar > ./mytestclass.jar
Search results for ./mytestclass.jar:
   SimpleTest not found in ./mytestclass.jar
searching jar > ./simpletest.jar
Search results for ./simpletest.jar:
   Found target
   546 Thu Dec 30 09:44:06 CST 2010 SimpleTest.class
   189 Thu Dec 30 09:44:06 CST 2010 SimpleTest.java
found file in location > ./test01/test02/SimpleTest.txt
