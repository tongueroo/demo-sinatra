Jets.deploy.configure do
  # config.deployment.type = "lambda"
  # config.deployment.builder = "docker"

  # config.deployment.type = false

  config.deployment.type = "ecs"
  config.deployment.builder = "buildpack"

  if RbConfig::CONFIG["arch"].include?("x86_64")
    config.ecs.service.capacity_provider_strategy = [
      {
        CapacityProvider: "FARGATE_SPOT",
        Weight: 1
      }
    ]
  end

  # config.ecs.tasks.web.cpu = 2048
  # config.ecs.tasks.web.memory = 4096
end
