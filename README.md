# Jenkins Infrastructure
This are attempt to configure Jenkins infrastructure using docker-compose.

What included here is:
- Jenkins as master
- Jenkins slave

## Configure Key

Prepare the key using
```shell
$ make key
```

This key will be use for authentication the ssh slave.

## Run
Then run the compose
```shell
$ docker-compose up -d
```

## Slave
Configure slave on `Manage Jenkins > Manage Node`

## Docker
To enable the docker, we have to add Docker tool on `Manage Jenkins > Global Tool Configuration`. Use auto installation from https://docker.io.

Set environment variable `Manage Jenkins > Configure System`, on `Global Properties`

```properties
DOCKER_HOST=tcp://dockerd:2375
```

or manually by using `tool` command on Pipeline script
```groovy
node {
  // Need to configure tool on 'Global Tool Configuration'
  def root = tool name: 'Docker'
  withEnv(["PATH+DOCKER=${root}/bin", "DOCKER_HOST=tcp://dockerd:2375"]) {
    sh "docker version"
  }
}
```
