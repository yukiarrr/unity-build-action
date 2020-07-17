const core = require("@actions/core");
const exec = require("@actions/exec");

async function run() {
  try {
    process.env.UNITY_VERSION = core.getInput("unity-version");

    await exec.exec(`bash ${__dirname}/returnlicense.sh`);
  } catch (error) {
    core.setFailed(error.message);
  }
}

run();
