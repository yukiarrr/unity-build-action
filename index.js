const core = require("@actions/core");
const childProcess = require("child_process");

process.env.UNITY_VERSION = core.getInput("unity-version");
process.env.UNITY_LICENSE_BASE64 = core.getInput("unity-license-base64");
process.env.BUILD_TARGET = core.getInput("build-target");
process.env.PROJECT_PATH = core.getInput("project-path");
process.env.EXECUTE_METHOD = core.getInput("execute-method");
process.env.OUTPUT_PATH = core.getInput("output-path");
process.env.COMMAND_ARGS = core.getInput("command-args");

childProcess.spawnSync("/bin/bash", [`${__dirname}/build.sh`], {
  stdio: [process.stdin, process.stdout, process.stderr],
  encoding: "utf-8"
});
