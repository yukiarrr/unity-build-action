#!/bin/bash -e

if [ "$(uname)" = 'Darwin' ]; then
  unity_path="/Applications/Unity/Hub/Editor/${UNITY_VERSION}/Unity.app/Contents/MacOS/Unity"
elif [ "$(uname -s | cut -c -5)" = 'Linux' ]; then
  unity_path="~/Unity/Hub/Editor/${UNITY_VERSION}/Unity"
elif [ "$(uname -s | cut -c -5)" = 'MINGW' -o "$(uname -s | cut -c -7)" = 'MSYS_NT' ]; then
  unity_path="C:/Program Files/Unity/Hub/Editor/${UNITY_VERSION}/Unity.exe"
fi

"$unity_path" -batchmode -nographics -quit -silent-crashes -logFile editor.log -returnlicense
cat editor.log
