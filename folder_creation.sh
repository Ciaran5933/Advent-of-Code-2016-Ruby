#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Usage: $0 <day number>"
    exit 1
fi

DAY="$1"

mkdir day${DAY}
cd day${DAY}

touch part1.rb
touch part2.rb
touch input.txt
touch readme.md