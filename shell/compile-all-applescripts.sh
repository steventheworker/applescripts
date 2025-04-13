# made under assumption: called FROM  /shell
cd ../applescript || exit
rm -rf compiled && mkdir compiled && cd compiled # delete + remake + cd: compiled
rsync -a -f"+ */" -f"- *" ../ ./ # copy structure of /applescript into it (from ../ to ./)
cd ../../shell || exit # go back to our original working directory (/shell)

for filePath in ../applescript/**/*.applescript; do
  relPath="${filePath#../*/}" # remove component (s?)
  relPath="${relPath:h}"
  name="${filePath%.*}" # remove extension from full path
  name=${name:t} # last component only

  if [ "$relPath" = "." ]; then
     relPath=""
   else
     relPath="$relPath/"
  fi

  name="../applescript/compiled/${relPath}$name.scpt"
  osacompile -o "${name}" "${filePath}"
done
