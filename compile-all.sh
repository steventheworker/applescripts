for filePath in ./*.applescript; do
   # do some stuff here with "$f"
   # remember to quote it or spaces may misbehave
   name=${filePath%????????????}.scpt # name w/o extension
   echo "file ${name} successfully created"
   osacompile -o "${name}" "${filePath}"
done
