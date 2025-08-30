# used on purp (Ubuntu) - give shell script file a nickname(s)
if [ -z "$1" ]
then
   echo "No argument supplied"
   exit 1
fi
nn=$1 # script nickname

if [ "$nn" = "cat" ]; then bash ./Desktop/important/catvid.sh;
elif [ "$nn" = "ap" ]; then bash ./Desktop/important/toggle-airpods.sh
elif [ "$nn" = "icons" ]; then bash ./Desktop/important/desktop-icons.sh
elif [ "$nn" = "watch" ]; then fswatch -o "${PWD}" | xargs -n1 -I{} ~/proj/.zsh/gitdiff.sh
elif [ "$nn" = "invert" ]; then bash ~/scripts/shell/invert.sh "$2"
fi
