# Inception

Build and configure a mini server infrastructure using Docker and Docker compose inside a virtual machine.

# Inderstanding the basics

## 🐳 Docker
**Docker** is an open platform for developing, shipping and running applications. It provides the ability to run an appication in isolated environment called a **container**, the isolation and security lets you run many containers simultaneously on a given host.

## Docker VS Virtual Machines
Docker and Virtual Machines both help you run applications in isolated environments, but Docker offers several advantages:

![Docker vs VM](srcs/assets/docker.png)

## Dockerfile
**Dockerfile** is a text file that contains a set of instructions to build a **Docker image**
**Think of it like a recipe:** it tells Docker how to create an environment with everything your app or service needs to run.

**Here are the most useful Dockerfile instructions:**

`FROM debian:bullseye`  
This line is usually the first instruction in a Dockerfile.
Here's what it means:
**debian:** is the name of the linux distribution.
**bullseye:** is the code name of a specific version(Debian 11).
Sets the base image for your image : when you create a Docker image, you don't build everything from scratch, you start with an existing base image.

`COPY ./conf/default.conf /etc/nginx/conf.d/`  
Copy files or folders from your host machine into the image being built, so the container can use them when it runs.

`RUN apt-get update && apt-get install -y nginx`  
Executes a shell command during the image creation, not when the container starts.

`EXPOSE 443`  
Documents which port the container listens on (in this example : 443)

`CMD ["nginx", "-g", "daemon off;"]`  
Defines the default command and arguments to run when the container starts.
It can be overridden at runtime using `docker run`

`ENTRYPOINT ["bash", "/tools/mariadb.sh"]`  
Sets the main command that will always run, even if the user provides arguments.
It can be combined with `CMD` to provide default arguments.

## Docker Images
**Docker image** is a blue print for creating containers, it contains (code, dependecies, OS environment, scripts, files, ..)
You build an image with: `docker build -t image-name`
You run a container from that image: `docker run image-name`
You can create multiple running containers from the same image.

## Container
**Container** is a running version from a Docker image
`docker ps` list running containers
`docker exec -it container-name bash` Enters a running container's shell

## Docker Volume
**Docker volume** is a special storage location on your host system, it lets your container store data outside its own filesystem, so the data persists even if the container is stopped, deleted, or rebuilt.

## Docker Network
**Docker Network** allows containers to communicate with each other in a secure, isolated and controlled way.
**bridge** is a network type for a single-host setups, most common for local development.

## Docker Compose
**Docker compose** is a tool that lets you define and run multi-container Docker applications using a simple YAML file.
