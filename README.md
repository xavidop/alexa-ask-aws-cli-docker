# Docker image for ASK and AWS CLI 

The purpose of this container is to be able to use the [Amazon ASK CLI (Alexa Skills Kit)](https://developer.amazon.com/docs/smapi/ask-cli-intro.html#alexa-skills-kit-command-line-interface-ask-cli) in a Docker container in Devops pipelines.

**NOTE:** This is a fork from [martindsouza](https://github.com/martindsouza/docker-amazon-ask-cli) image with these changes:
1. Image base is the latest LTS version instead of the current version of Node.js.
2. Added ASK_CLI_VERSION build argument in order to be able to work with different ASK CLI versions.
3. Added git and zip packages that ASK CLI will use in its commands.
4. Added Bespoken.
5. Remove volumes. I think it is not necessary in a simple docker image that I will use in my devops pipelines. In addition, you can use '-v' argument in `docker run` command whenever you want.

## ASK Config

Before running this example ensure that you've registered for an [Alexa Developer](https://developer.amazon.com/alexa) account.

### ask configure

Running `ask configure` in v2 and `ask init` in v1 in the container will ask you a set of questions to create the Alexa credentials. Follow all the steps explained in the official documentation[https://developer.amazon.com/en-US/docs/alexa/smapi/manage-credentials-with-ask-cli.html].

In either case ensure that you pass in `-v $(pwd)/ask-config:/home/node/.ask \` (where `$(pwd)/ask-config` is a location on your host machine) as an option when running the container to preserve the ASK configuration.

### Setting credentials using environment variables

You can store Alexa credentials in environment variables instead of the Alexa credentials file. If the Alexa environment variables exist, ASK CLI uses them instead of the values in the Alexa credentials file. ASK CLI searches for the following Alexa environment variables:

You can use the ASK CLI environment variables in conjunction with or in addition to the ASK CLI configuration file. The following list describes the ASK CLI environment variables.

* `ASK_DEFAULT_PROFILE`: Use this environment variable in conjunction with the ASK CLI configuration file. When you set the value of this environment variable to one of the profiles in the configuration file, ASK CLI uses the credentials in that profile.
* `ASK_ACCESS_TOKEN`: Use this environment variable to store an Amazon developer access token. When this environment variable exists, ASK CLI uses it instead of the credentials in the configuration file.
* `ASK_REFRESH_TOKEN`: Use this environment variable to store an Amazon developer refresh token. When this environment variable exists, ASK CLI uses it instead of the credentials in the configuration file. When this environment variable and ASK_ACCESS_TOKEN both exist, ASK CLI uses this one.
* `ASK_VENDOR_ID`: Use this environment variable to store an Amazon developer vendor ID. When this environment variable exists, ASK CLI uses it instead of the one it the configuration file.
* `ASK_CLI_PROXY`: Use this environment variable to specify an HTTP proxy for requests made with the ASK CLI.
  
If you want to know how to get the `ASK_REFRESH_TOKEN` and `ASK_ACCESS_TOKEN`, see [this page](https://developer.amazon.com/en-US/docs/alexa/smapi/get-access-token-smapi.html) in the Alexa documentation.

If you want to know how to get the `ASK_VENDOR_ID`, you only have to enter to [this page](https://developer.amazon.com/settings/console/mycid).

If you are using Alexa environment variable you have to add a new profile called `__ENVIRONMENT_ASK_PROFILE__` in your `.ask/config` file

## AWS Config

If you plan to use [Lambda](https://aws.amazon.com/lambda/) you'll need to configure the AWS CLI. To simplify. You can configure it multiple ways.

In either case ensure that you pass in `-v $(pwd)/aws-config:/home/node/.aws \` (where `$(pwd)/aws-config` is a location on your host machine) as an option when running the container to preserve the AWS configuration.

### aws configure

Running `aws configure` in the container will ask you a set of questions to create the AWS credentials

### Setting credentials using environment variables

You can store AWS credentials in environment variables instead of the AWS credentials file. If the AWS environment variables exist, ASK CLI uses them instead of the values in the AWS credentials file. ASK CLI searches for the following AWS environment variables:

* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`
  
For more information about the [AWS environment variables](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html), see Environment Variables in the AWS documentation.


## Usage

Get the latest version of the container: `docker pull xavidop/alexa-ask-aws-cli`

```bash
  # Get image
  docker pull xavidop/alexa-ask-aws-cli
```

They're two ways to use the `ask` cli for this container which are covered below.

### Run One Command

In this mode the container will start, you run your `ask` command, then the container is stopped and deleted. _Don't worry your Docker image is still kept._

```bash
docker run -it --rm \
  -v $(pwd)/ask-config:/home/node/.ask \
  -v $(pwd)/hello-world:/home/node/app \
  xavidop/alexa-ask-aws-cli:latest \
  ask init -l
```

### Run `bash`, then run `ask`

In this mode, the container will start, you can then run the container's bash, and the container will stop and delete only once you `exit`.

```bash
docker run -it --rm \
  -v $(pwd)/ask-config:/home/node/.ask \
  -v $(pwd)/app/HelloWorld:/home/node/app \
  xavidop/alexa-ask-aws-cli:latest \
  bash

# You'll be prompted with:
# bash-4.3$
#
# Type: exit  to end and terminate the container
```

## Developers

For ASK CLI v1:
```bash
docker build --build-arg ASK_CLI_VERSION=1.7.23 -t xavidop/alexa-ask-aws-cli:1.0 .

# Pushing to Docker Hub
# Note: not required since I have a build hook linked to the repo
docker login
docker push xavidop/alexa-ask-aws-cli
```

For ASK CLI v2:
```bash
docker build --build-arg ASK_CLI_VERSION=2.1.1 -t xavidop/alexa-ask-aws-cli:2.0 .

# Pushing to Docker Hub
# Note: not required since I have a build hook linked to the repo
docker login
docker push xavidop/alexa-ask-aws-cli
```

## Versions

Currently there are two versions available:
* 1.0: this image is running the latest version of ASK CLI v1 (1.7.23)
* 2.0: this image is running the latest version of ASK CLI v2 (2.1.1)

These versions are available in my [DockerHub profile](https://hub.docker.com/r/xavidop/alexa-ask-aws-cli/tags)

## Links:

- [ASK CLI Quickstart](https://developer.amazon.com/docs/smapi/quick-start-alexa-skills-kit-command-line-interface.html)
- [ASK CLI Full Doc](https://developer.amazon.com/docs/smapi/ask-cli-intro.html#alexa-skills-kit-command-line-interface-ask-cli)

