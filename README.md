# Shipping Containerized Node.js Apps with AWS ECS

This repo is part of a blog series covering how to ship containerized Node.js
apps using Amazon's Elastic Container Service (ECS).

- [Dockerizing a Node.js App](https://blog.devopsdreams.io/thinking-inside-the-box)
- [Using AWS ECR](https://blog.devopsdreams.io/container-yourself)
- [ECS Task Definitions](https://blog.devopsdreams.io/ecs-task-definitions)
- [ECS Services ](https://blog.devopsdreams.io/ecs-services)
- [Automating ECS](https://blog.devopsdreams.io/automating-ecs)

# Notes

Scripts in this repo assume you are using [direnv](https://direnv.net), and have a `.envrc` file
containing the following:

```bash
# Script settings
export AWS_ACCOUNT_ID="012345678901"
export PROFILE="default"
export REGION="us-east-2"
export REPO_URI="${AWS_ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/hello-world-production"
# Terraform settings
export AWS_PROFILE="$PROFILE"
export AWS_DEFAULT_PROFILE="$PROFILE"
export AWS_DEFAULT_REGION="$REGION"
export AWS_SDK_LOAD_CONFIG=1
# App settings
export LISTEN_HOST="0.0.0.0"
export LISTEN_PORT="8080"
```

