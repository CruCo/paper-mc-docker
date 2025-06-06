# paper-mc-docker
A quick and dirty setup for a papermc minecraft server running as docker container

## Basic information
This repository is just a demonstration on how to run a papermc minecraft server from a build source.
No image will be published. Rather you clone this repository and run the docker compose command on your target machine.

For me it was just a blueprint to run a papermc, but feel free to use and change this as you need.

###  Under the hood
The dockerfile takes the variable MC_VERSION and resolves the latest build for the given minecraft version via the [papermc projects api](https://api.papermc.io/v2/projects/paper).
It will automatically download the jar file and place it in the working directory.

This approach eliminates the need to get rid of old jar files. Much rather you can simply increase the version flag if needed and hit the docker compose up command with build flag again.

### Prerequisites
Make sure docker and docker compose is up to date and running on your machine.

## Configure the image
Make sure to prepare your machine with the necessary variables to configure the build in the way you need it.


### Build arguments
As exposed in the compose.yml the following build arguments are used and can be changed on your behalf:
|Argument|Default value|Description|
|---|---|---|
|MC_VERSION|1.21.5|Used to build a specific version of minecraft. Change this if you need another version|
|UNAME|papermc|Username which is used to build and run the container. Necessary to run as a non root user. Check if $USER is set on the machine.|
|COMPOSE_UID|-|Userid of the user. Set on the machine to uid you want.|
|COMPOSE_GID|-|Groupid of the user. Set on the machine to gid you want.|


### Environment variables
|Variablename| Default value| Description|
|---|---|---|
|MIN_RAM | 1G | Used to set the -xms for the JVM inside of docker. Change this if you need more or less RAM on startup|
|MAX_RAM | 8G | Used to set the -xmx for the JVM inside of docker. Change this if you need a higher maxmimum RAM during runtime|

## Run mc server
Use the command
> docker compose up -d --build

to run the server. The first run takes some time.

### Attach and detach
The server is started in detached mode. In order to attach to your minecraft server (e.g. to issue server commands) run the following command on the host machine
> docker attach mc-server

While being attached you can than detach again by hitting the following key-strokes
`Ctrl + p` and than `Ctrl + q`

## Server config and backup

### Configuration
To configure place all config files inside of a folder "config". These files are mounted into the minecraft server folder parallel to the server.jar.


So in order to configure the server with the files displayed in the [papermc config reference ](https://docs.papermc.io/paper/reference/configuration), place the files with your specific configuration in the "config" folder.

It is necessary, that the files are present so in this Repository they are added like they are as default.

**ADAPT TO YOUR NEED AND BACK THEM UP**

### Plugin and world backups
For configuration and backup purposes the docker compose creates two local folders in your filesystem outside of your docker container. This has a little performance impact but is easier to make changes to the server configuration on the fly.

World data is saved into /world folder. Add any plugin you need to /plugin folder.

## Important information

### EULA
By running the command you are automatically accepting the EULA of Mojang AB and Microsoft Corporation. This is set to default and needs to be set to true in order to run it.

### System cleanup
When you run this project for a long time you start to pollute your system with docker build cache artifacts. It can help to clean the system from time to time with

> docker system prune