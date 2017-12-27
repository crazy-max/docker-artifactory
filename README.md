<p align="center">
  <a href="https://travis-ci.org/crazy-max/docker-artifactory"><img src="https://img.shields.io/travis/crazy-max/docker-artifactory/master.svg?style=flat-square" alt="Build Status"></a>
  <a href="https://hub.docker.com/r/crazymax/artifactory/"><img src="https://img.shields.io/docker/stars/crazymax/artifactory.svg?style=flat-square" alt="Docker Stars"></a>
  <a href="https://hub.docker.com/r/crazymax/artifactory/"><img src="https://img.shields.io/docker/pulls/crazymax/artifactory.svg?style=flat-square" alt="Docker Pulls"></a>
</p>

## About

This is a simple mirror of [Artifactory](https://jfrog.com/artifactory/) Docker images taken from [JFrog Docker Registry](https://bintray.com/jfrog/reg2) and push to [Docker Hub](https://hub.docker.com/r/crazymax/artifactory/).

The following images are mirrored :

* [artifactory-oss](https://bintray.com/jfrog/reg2/jfrog%3Aartifactory-oss) : Artifactory Community Edition
* [artifactory-pro](https://bintray.com/jfrog/reg2/jfrog%3Aartifactory-pro) : Artifactory Pro
* [nginx-artifactory-pro](https://bintray.com/jfrog/reg2/jfrog%3Anginx-artifactory-pro) : Nginx image to act as reverse proxy for Artifactory Pro

And are placed in the same repository on Docker Hub with translated tags. Here is a translation example :

| JFrog registry                                       | Docker Hub                           |
| ---------------------------------------------------- | ------------------------------------ |
| docker.bintray.io/jfrog/artifactory-oss:latest       | crazymax/artifactory:oss-latest      |
| docker.bintray.io/jfrog/artifactory-pro:5.7.2        | crazymax/artifactory:pro-5.7.2       |
| docker.bintray.io/jfrog/nginx-artifactory-pro:5.7.2  | crazymax/artifactory:nginx-pro-5.7.2 |

For more info : https://github.com/JFrogDev/artifactory-docker-examples
