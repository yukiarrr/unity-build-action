#!/bin/bash -e

if ! type u3d > /dev/null 2>&1; then
  sudo gem install u3d
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
  [ "$(uname -s | cut -c -5)" = 'Linux' ] && sudo u3d dependencies
fi

sudo u3d install $UNITY_VERSION -p Unity,${BUILD_TARGET}

script_path=$(cd $(dirname $0); pwd)
rsync -a ${script_path}/Assets/ ${PROJECT_PATH}/Assets/

echo $UNITY_LICENSE_BASE64 | base64 --decode > Unity.ulf
u3d -u $UNITY_VERSION --trace -- -batchmode -nographics -quit -silent-crashes -logFile -manualLicenseFile Unity.ulf || true
u3d -u $UNITY_VERSION --trace -- -projectPath $PROJECT_PATH -batchmode -nographics -quit -silent-crashes -logFile -buildTarget $BUILD_TARGET -executeMethod $EXECUTE_METHOD -outputPath $OUTPUT_PATH $COMMAND_ARGS
