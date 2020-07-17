#!/bin/bash -e

sudo_gem='gem'
sudo_u3d='u3d'
if type sudo > /dev/null 2>&1; then
  sudo_gem="sudo $sudo_gem"
  sudo_u3d="sudo $sudo_u3d"
fi

if ! type u3d > /dev/null 2>&1; then
  $sudo_gem install u3d
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
  if [ "$(uname -s | cut -c -5)" = 'Linux' ]; then
    sudo apt-get install -y libglu1-mesa
    $sudo_u3d dependencies
  fi
fi

[ ! "$(u3d list | grep $UNITY_VERSION)" ] && $sudo_u3d install $UNITY_VERSION -p Unity,${BUILD_TARGET}

script_path=$(cd $(dirname $0); pwd)
rsync -a ${script_path}/Assets/ ${PROJECT_PATH}/Assets/

set +e
u3d -u $UNITY_VERSION -- -projectPath $PROJECT_PATH -batchmode -nographics -quit -silent-crashes -logFile editor.log -username $UNITY_USERNAME -password $UNITY_PASSWORD -serial $UNITY_SERIAL -buildTarget $BUILD_TARGET -executeMethod $EXECUTE_METHOD -outputPath $OUTPUT_PATH $COMMAND_ARGS
exit_code=$?
cat editor.log
exit $exit_code
