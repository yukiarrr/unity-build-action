#!/bin/bash -e

u3d -u $UNITY_VERSION -- -batchmode -nographics -quit -silent-crashes -logFile editor.log -returnlicense
cat editor.log
