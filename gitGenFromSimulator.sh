#!/bin/sh
DATETIME=`date +%Y%m%d_%H%M%S`
echo $DATETIME

trap "final; exit 1" 2

function final {
  echo "Ctrl+C pushed."

  # mov -> gif by using ffmpeg
  # ref. https://qiita.com/yusuga/items/ba7b5c2cac3f2928f040 
  # ffmpeg -i $DATETIME.mov -r 10 -vf scale=640:-1 -f gif $DATETIME.gif
  ffmpeg -i $DATETIME.mov -filter_complex "[0:v] fps=10,scale=640:-1,split [a][b];[a] palettegen [p];[b][p] paletteuse" $DATETIME.gif
}

xcrun simctl io booted recordVideo $DATETIME.mov

