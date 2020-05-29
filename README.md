<p align="center">
  <a href="https://github.com/crazy-max/docker-artifactory/actions?workflow=build"><img src="https://img.shields.io/github/workflow/status/crazy-max/docker-artifactory/build?label=build&logo=github&style=flat-square" alt="Build Status"></a>
  <a href="https://hub.docker.com/r/crazymax/artifactory/"><img src="https://img.shields.io/docker/stars/crazymax/artifactory.svg?style=flat-square&logo=docker" alt="Docker Stars"></a>
  <a href="https://hub.docker.com/r/crazymax/artifactory/"><img src="https://img.shields.io/docker/pulls/crazymax/artifactory.svg?style=flat-square&logo=docker" alt="Docker Pulls"></a>
</p>

## About

This is a simple mirror of [Artifactory](https://jfrog.com/artifactory/) Docker images taken from [JFrog Docker Registry](https://bintray.com/jfrog/reg2) and push to [Docker Hub](https://hub.docker.com/r/crazymax/artifactory/).<br />
If you are interested, [check out](https://hub.docker.com/r/crazymax/) my other Docker images!

💡 Want to be notified of new releases? Check out 🔔 [Diun (Docker Image Update Notifier)](https://github.com/crazy-max/diun) project!

The following images are mirrored:

* [artifactory-oss](https://bintray.com/jfrog/reg2/jfrog%3Aartifactory-oss) : Artifactory Community Edition
* [artifactory-pro](https://bintray.com/jfrog/reg2/jfrog%3Aartifactory-pro) : Artifactory Pro
* [nginx-artifactory-pro](https://bintray.com/jfrog/reg2/jfrog%3Anginx-artifactory-pro) : Nginx image to act as reverse proxy for Artifactory Pro
* [postgres](https://bintray.com/jfrog/reg2/postgres) : PostgreSQL

And are placed in the same repository on Docker Hub with translated tags. Here is a translation example:

| JFrog registry                                       | Docker Hub                           |
| ---------------------------------------------------- | ------------------------------------ |
| docker.bintray.io/jfrog/artifactory-oss:latest       | crazymax/artifactory:oss-latest      |
| docker.bintray.io/jfrog/artifactory-pro:5.7.2        | crazymax/artifactory:pro-5.7.2       |
| docker.bintray.io/jfrog/nginx-artifactory-pro:5.7.2  | crazymax/artifactory:nginx-pro-5.7.2 |
| jfrog-docker-reg2.bintray.io/postgres:9.5.2          | crazymax/artifactory:postgres-9.5.2  |

For more info : https://github.com/JFrogDev/artifactory-docker-examples
