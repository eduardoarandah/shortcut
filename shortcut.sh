#!/bin/bash

RCPATH="$HOME/.scrc"

declare -A shortcuts

# Read shortcuts from file
while read key val
do
  shortcuts["$key"]=$val
done < $RCPATH

# Set shortcut
if [ $2 ]
then
  # Expand path
  path=$(readlink -m $2)

  # Set new shortcut
  shortcuts["$1"]=$path

  # Empty out file
  > $RCPATH

  # Write new shortcuts
  for key in "${!shortcuts[@]}"
  do
    echo "$key ${shortcuts[$key]}" >> $RCPATH
  done
# Use shortcut
elif [ $1 ]
then
  echo "${shortcuts[$1]}"
fi
