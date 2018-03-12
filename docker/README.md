# DevOps

### Part 1: Provision Docker Image with Ansible
- [Docker Hub](https://hub.docker.com/r/megamanics/docker/)

### Pre-reqs:
- [Ansible](https://docs.ansible.com/ansible/intro_installation.html)

### What it does:
- Sets up vpn inside a docker image using Ansible

### How to run:

```
docker pull megamanics/docker:vpn
docker run -p 8080:8080 --name vpn megamanics/docker:vpn
```

### How to build and run:

```
docker rm vpn
docker rmi megamanics/docker:vpn
docker build --no-cache=true --label vpn-debian --rm  -t megamanics/docker:vpn .
docker image     prune -f
docker container prune -f
docker images
docker image inspect megamanics/docker:vpn
docker image history megamanics/docker:vpn
docker push megamanics/docker:vpn
docker run -d -l vpn -P -it --name vpn megamanics/docker:vpn
docker attach vpn
```

