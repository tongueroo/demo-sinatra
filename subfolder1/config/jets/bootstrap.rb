Jets.bootstrap.configure do
  config.codebuild.project.environment = {
    ComputeType: "BUILD_GENERAL1_MEDIUM",
    Image: "aws/codebuild/amazonlinux2-x86_64-standard:5.0",
    Type: "LINUX_CONTAINER"
  }

  if RbConfig::CONFIG["arch"].include?("x86_64")
    docker_host = "DOCKER_HOST_X86_64"
    jets_ssh_key = "JETS_SSH_KEY_X86_64"
    jets_ssh_known = "JETS_SSH_KNOWN_X86_64"
  else
    docker_host = "DOCKER_HOST"
    jets_ssh_key = "JETS_SSH_KEY"
    jets_ssh_known = "JETS_SSH_KNOWN"
  end

  # Docs: http://rubyonjets.com/docs/remote/codebuild/
  config.codebuild.project.env.vars = {
    JETS_DEBUG: 1,
    JETS_LOG_LEVEL: "debug",

    DOCKER_HOST: "SSM:/#{ssm_env}/#{docker_host}",
    JETS_SSH_KEY: "SSM:/#{ssm_env}/#{jets_ssh_key}",
    JETS_SSH_KNOWN: "SSM:/#{ssm_env}/#{jets_ssh_known}",

    JETS_REMOTE_VERSION: "ecs",
    JETS_VERSION: "ecs",
    DOCKER_PASS: "SSM:/#{ssm_env}/DOCKER_PASS",
    DOCKER_USER: "SSM:/#{ssm_env}/DOCKER_USER"
  }
end
