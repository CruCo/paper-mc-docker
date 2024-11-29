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

## Run mc server
Use the command
> docker compose up -d --build

to run the server. The first run takes some time.

## Settings
|Variablename| Default value| Description|
|---|---|---|
|MC_VERSION| 1.21.3 | Used to build a specific version of minecraft. Change this if you need another version |
|MIN_RAM | 1G | Used to set the -xms for the JVM inside of docker. Change this if you need more or less RAM on startup|
|MAX_RAM | 8G | Used to set the -xmx for the JVM inside of docker. Change this if you need a higher maxmimum RAM during runtime|

## Server config and backup
For configuration and backup purposes the docker compose creates two local folders in your filesystem outside of your docker container. This has a little performance impact but is easier to make changes to the server configuration on the fly.

World data is saved into /world folder. Add any plugin you need to /plugin folder.

## Important
By running the command you are automatically accepting the EULA of Mojang AB and Microsoft Corporation. This is set to default and needs to be set to true in order to run it.