# DOCKER TRAINING - MY DEVELOPMENT ENVIRONMENT

## INTRO TO DOCKER 

Containerization is an additional step in the virtualization of the environment. 

Step 0: Original approach (no virtualization): an actual machine was acquired upfront to install and configure an environment ready to run many application. Just part of the hw was used and the cost of the configuration was paid any time there was the need to migrate to a different system

Step 1: Virtualization based on hypervisor: Hypervisor is used to create multiple virtual machines. Even though the same hardware can be used to run different systems (easy to scale), there is a cost in terms of kernel duplication (each virtual machine duplicates an entire OS) and portability (compatibility between OS/Applications and Virtual Machine)

Step 2: Containerization share the details of the kernel. They are are easy to deploy and the portability is guaranteed

### DOCKER CLIENT-SERVER MODEL

Docker uses a client-server approach. The docker commands (e.g. docker pull, docker build, docker run,...) are called by the client (command line or kinematic UI) and executed on the docker daemon (docker engine or docker server) on the docker host. Typically the docker host and docker client run on the same machine (within a VM if the OS is windows or mac OX because there are some requirements on Linux features).

### MAIN CONCEPTS

The key concepts about docker are:

Images: The images are templates used to create containers (similar to object and class relationship). The docker images are stored in a registry (see dockerhub:https://hub.docker.com ) and they are created by running docker build command. Given that the image can become huge it is composed into different layers that are downloaded separately. Using official images from the public registry has several up sides such as a clear documentation, dedicated team for content review and security updates.

Container: lightweight environment to encapsulate and run applications.

Registry: Images are stored in the docker registry. It can be a private registry but the public docker registry is DockerHub. 

Repository: Inside a registry, the images are stored into repositories. A docker repository is a collection of different images with the same name but different tags (usually representing different versions) 

### SOME DOCKER COMMANDS

docker images
Lists of the images available locally

docker ps
Lists the container running

docker ps -a
Lists all the container executed

docker run -it -d <docker images ID> 
Run the container in background (-d) using the interactive mode

docker run --rm <docker images ID>
Run the container and remove it once completed

docker log
Allows to see the container logs


