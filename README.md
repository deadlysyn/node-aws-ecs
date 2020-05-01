# Shipping Node.js Apps with AWS ECS

This repo is part of a blog series covering how to ship containerized Node.js
apps using Amazon's Elastic Container Service (ECS).

- [Dockerizing a Node.js App](https://blog.devopsdreams.io/thinking-inside-the-box)
- [Using AWS ECR](https://blog.devopsdreams.io/container-yourself)
- [ECS Task Definitions](https://blog.devopsdreams.io/ecs-task-definitions)
- [ECS Services ](https://blog.devopsdreams.io/ecs-services)
- [Automating ECS](https://blog.devopsdreams.io/automating-ecs)

# Setup

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

# Use

To deploy, change into the `terraform` directory then:

```console
terraform init
terraform plan -var-file=hello-world.tfvars -out=plan
terraform apply plan
# ...
terraform destroy -var-file=hello-world.tfvars
```

Once the ECS infra is plumbed, push updates using the `do` admin script from project root.
It will let you build and run a local image and deploy to ECS, and depends on a
`terraform/${environment}.repo` file populated by `terraform output ecr_repo > terraform/${environment}.repo`.

```console
➜ ./scripts/do
USAGE: do build|start|stop|restart|push

➜ ./scripts/do push production
# ...
```
