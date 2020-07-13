#!/bin/bash -e

if [ "$(uname)" = 'Darwin' ]; then
  if [ ! -e '/Applications/Unity Hub.app' ]; then
    curl -LO https://public-cdn.cloud.unity3d.com/hub/prod/UnityHubSetup.dmg
    hdiutil mount UnityHubSetup.dmg
    current_path=$(pwd)
    cd '/Volumes/Unity Hub'*
    ditto 'Unity Hub.app' '/Applications/Unity Hub.app'
    cd "$current_path"
    hdiutil detach '/Volumes/Unity Hub'*
    rm -f UnityHubSetup.dmg
  fi
  unity_hub_path='/Applications/Unity Hub.app/Contents/MacOS/Unity Hub'
  unity_path="/Applications/Unity/Hub/Editor/${UNITY_VERSION}/Unity.app/Contents/MacOS/Unity"
elif [ "$(uname -s | cut -c -5)" = 'Linux' ]; then
  if [ ! -e '~/Unity Hub' ]; then
    curl -LO https://public-cdn.cloud.unity3d.com/hub/prod/UnityHub.AppImage
    chmod +x UnityHub.AppImage
    ./UnityHub.AppImage
    rm -f UnityHub.AppImage
    if type apt > /dev/null 2>&1; then
      sudo apt install libgconf-2-4
    fi
    if type yum > /dev/null 2>&1; then
      sudo yum install mesa-libGLU
    fi
  fi
  unity_hub_path='~/Unity Hub/Unity Hub'
  unity_path="~/Unity/Hub/Editor/${UNITY_VERSION}/Unity"
elif [ "$(uname -s | cut -c -5)" = 'MINGW' -o "$(uname -s | cut -c -7)" = 'MSYS_NT' ]; then
  if [ ! -e 'C:/Program Files/Unity Hub' ]; then
    curl -LO https://public-cdn.cloud.unity3d.com/hub/prod/UnityHubSetup.exe
    ./UnityHubSetup.exe //S
    rm -f UnityHubSetup.exe
  fi
  unity_hub_path='C:/Program Files/Unity Hub/Unity Hub.exe'
  unity_path="C:/Program Files/Unity/Hub/Editor/${UNITY_VERSION}/Unity.exe"
fi

if [ ! `echo $("$unity_hub_path" -- --headless editors --installed) | grep $UNITY_VERSION` ]; then
  "$unity_hub_path" -- --headless install --version $UNITY_VERSION --module $BUILD_TARGET --changeset $CHANGESET
fi

script_path=$(cd $(dirname $0); pwd)
project_path=$(cd "$PROJECT_PATH"; pwd)
cp -r "${script_path}/Assets/." "${project_path}/Assets"

set +e
"$unity_path" -projectPath "$project_path" -batchmode -nographics -quit -silent-crashes -logFile editor.log -username $UNITY_USERNAME -password $UNITY_PASSWORD -serial $UNITY_SERIAL -buildTarget $BUILD_TARGET -executeMethod $EXECUTE_METHOD -outputPath "$OUTPUT_PATH" $COMMAND_ARGS
exit_code=$?
cat editor.log
exit $exit_code
