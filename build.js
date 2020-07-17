const core = require("@actions/core");
const exec = require("@actions/exec");

async function run() {
  try {
    process.env.UNITY_VERSION = core.getInput("unity-version");
    process.env.UNITY_USERNAME = core.getInput("unity-username");
    process.env.UNITY_PASSWORD = core.getInput("unity-password");
    process.env.UNITY_SERIAL = core.getInput("unity-serial");
    process.env.BUILD_TARGET = core.getInput("build-target");
    process.env.PROJECT_PATH = core.getInput("project-path");
    process.env.EXECUTE_METHOD = core.getInput("execute-method");
    process.env.OUTPUT_PATH = core.getInput("output-path");
    process.env.COMMAND_ARGS = core.getInput("command-args");

    await exec.exec(`bash ${__dirname}/build.sh`);
  } catch (error) {
    core.setFailed(error.message);
  }
}

run();
