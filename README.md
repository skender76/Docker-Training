# DOCKER TRAINING - MY DEVELOPMENT ENVIRONMENT

## INTRO TO DOCKER 

Containerization is an additional step in the virtualization of the environment. 

- Step 0: Original approach (no virtualization): an actual machine was acquired upfront to install and configure an environment ready to run many application. Just part of the hw was used and the cost of the configuration was paid any time there was the need to migrate to a different system

- Step 1: Virtualization based on hypervisor: Hypervisor is used to create multiple virtual machines. Even though the same hardware can be used to run different systems (easy to scale), there is a cost in terms of kernel duplication (each virtual machine duplicates an entire OS) and portability (compatibility between OS/Applications and Virtual Machine)

- Step 2: Containerization share the details of the kernel. They are are easy to deploy and the portability is guaranteed

### DOCKER CLIENT-SERVER MODEL

Docker uses a client-server approach. The docker commands (e.g. docker pull, docker build, docker run,...) are called by the client (command line or kinematic UI) and executed on the docker daemon (docker engine or docker server) on the docker host. Typically the docker host and docker client run on the same machine (within a VM if the OS is windows or mac OX because there are some requirements on Linux features).

### MAIN CONCEPTS

The key concepts about docker are:

**Images**: The images are templates used to create containers (similar to the relationship between the class and the object). The docker images are stored in a registry (see [Docker Hub](https://hub.docker.com)) and they are created by running docker build command. Given that the image can become huge it is composed into different layers that are downloaded separately. Using official images from the public registry has several up sides such as a clear documentation, dedicated team for content review and security updates.

**Container**: lightweight environment to encapsulate and run applications.

**Registry**: Images are stored in the docker registry. It can be a private registry but the public docker registry is DockerHub. 

**Repository**: Inside a registry, the images are stored into repositories. A docker repository is a collection of different images with the same name but different tags (usually representing different versions) 

### SOME DOCKER COMMANDS

**docker images**
Lists of the images available locally

**docker ps**
Lists the container running

**docker ps -a**
Lists all the container executed

**docker run -it -d docker_images_ID** 
Run the container in background (-d) using the interactive mode

**docker run --rm docker_images_ID**
Run the container and remove it once completed

**docker log**
Allows to see the container logs

**docker run -it -d -p 8888:8080 tomocat:82**
It runs tomcat by mapping tomcat port 8080 on container port 8888

**docker-machine ls**
It provides info about the docker machine

**docker exec -it 123456789 /bin/bash**
Allows to execute a command within an existing container Iin this case 123456789)

**docker inspect 123456789**
Provides details about the configuration of the container

## WORKING WITH DOCKER

The images are composed by many layers corresponding to the different applications installed. Each layer is provided with a writable interface used to store the data generated when the container is running. Whenever the contanier is created the data is cancelled

The first images on top of the kernel it is called the **base image**. The underlying images for other images in the stack are called **reference images**.

The images can be created using two different approaches:

- By committing changes applied to a container (** docker commit container_ID repository_name:tag **)

- Using a dockerfile

In both case the scenario is:

1. Start a container from base image
2. Install the packages in the container
3. Commit the changes

### COMMITING CHANGES TO A CONTAINER

Create the base images (it will be downloaded from DokcerHub if not available locally)

* *docker run -it debian:jessie* *
* *apt-get update && apt-get install -y git* *

Type * *exit* * to exit from the container and retrieve the container ID by typing:

* *docker ps -a* *

Assuming that the container ID is 123456789, you can now commit the changes (in the examples below on my DockerHub account)

* *docker commit 123456789 skfiku76/debian:1.0* *

You can now run the new container

docker run -it skfiku76/debian:1.0

You will see that git is installed within skfiku/debian:1.0

#### Advanced Package Tool (apt)

* *apt-get update* *: it updates the dictionary of the packages with the latest versions
* *apt-get install -y package_name* *: it install the package by automatically answering "yes" at prompt (see -y option)  

### DOCKERFILE

A docker file is TXT file containing all the instructions to create the image. Each instruction corresponds to a layer. 

**docker build** command takes the path to the build context as an argument. When build starts, all the dockerfile are packed together and passed to the docker server. BY default the docker file is called **Dockerfile**

Create and edit the docker file:
* *touch Dockerfile* *
* *vi Dockerfile* *

Write the command to create the base image:
* *FROM debian/jessie* * 

Run the linux command to install the desired packages
* *RUN apt-get update* *
* *RUN apt-get install -y git* *
* *RUN apt-get install -y vim* *

Save the file and build the docker images

* *docker build -t skfiku76/debian .* *

In the command above, the build context is the content of the current folder. The content of the build context is packaged and copyed in the image 

* *Chain of RUN commands* * is used to reduced the number of images. This can be done using the following syntax:

* *RUN apt-get update && apt-get install -y \
	git
	vim* *

**CMD** instructions allows to specify the commands when the container is started (i.e. not executed at building time)

* *CMD ["echo", "hello world"]* *

The CMD can be overwritten by specifying a command inline when the docker is started

docker run 123456789 echo "hello!!!"

Docker cache is the mechanism to reuse the existing layer but this could lead to issues. You can disable the usage of cache 

**COPY** command copies files from the build context into the container

**ADD** command copies files also from internet to container

## PUSH CONTAINER TO DOCKERHUB

* *docker tag 123456789 skfiku76/myimage:1.01* *

* *docker login --username=skfiku76* *

* *docker push skfiku76/myimage:1.01* *

Eventually you will see skfiku76/myimage repository on DockerHub

## CONTAINER LINKS

It allow containers to discover each other and transfer data without knowing each other. The link is established by using container name

docker run -d --name redis redis:3.2.0

docker run -d -p 5000:5000 -link redis dockerapp:v0.3

## DOCKER COMPOSE

Docker Compose is a tool for defining and running multi-container Docker applications.

This is useful because it allows to simplify the definition of links between containers.

The configuration of the Docker Compose is based on **docker-compose.yml** file.

For instance, assuming we have two container (redis and dockerapp where dockerapp depends on redis):

touch docker-compose.yml
vi docker-compose.yml
version: '3'
services:
  dockerapp:
     build: .
     ports:
	- "5000:5000"
     dependency_on:
     - redis
   redis:
      image: redis:3.2.0

* docker-compose up -d 
* docker-compose logs 
* docker-compose stop
* docker-compose rm
* docker-compose ps
* docker-compose build

## DOCKER NETWORKING 




 

