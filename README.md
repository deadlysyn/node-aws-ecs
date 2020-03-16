# node-aws-ecs

This repo is part of a blog series covering how to ship containerized Node.js
apps using Amazon's Elastic Container Service (ECS).

- [Dockerizing a Node.js App](https://blog.devopsdreams.io/thinking-inside-the-box)
- [Using AWS ECR](https://blog.devopsdreams.io/container-yourself)

# Notes

Scripts in this repo assume you are using [direnv](https://direnv.net), and have a `.envrc` file
containing the following:

```bash
export PROFILE="aws-profile-name"
export REGION="aws-region-name"
export AWS_ACCOUNT_ID="012345678901"
export REPO_URI="repositoryUri value from ecr-create-repo output"
```

# References

TBD
