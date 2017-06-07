# Jenkins Infrastructure
This are attempt to configure Jenkins infrastructure using docker-compose.

What included here is:
- Jenkins as master
- Jenkins slave

## Run
Then run the compose
```shell
$ docker-compose up -d
```

## Slave
Prepare the keys stored on `slave.env` using
```shell
$ make slave.env
```

Then configure the slave on `Manage Jenkins > Manage Node > New Node`
1. Enter name "lucian"
2. Number of executor "2"
3. Remote root directory "/home/jenkins"
5. Launch method "Launch slave agents via SSH"
   - Host: "jenkins-slave-lucian"
   - Credentials: Add credentials (note: make sure you choose one after added new credentials)
     - Kind: SSH Username with private key
     - Username: jenkins
     - Private Key: Enter directly (paste from `keys/jenkins_slave_rsa`)
     - Passphrase: [same with the one we execute `make slave.env`]
     - ID: jenkins-slave
     - Description: Jenkins slave
  - Host Key Verification Strategy: Non verifying Verification Strategy



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
