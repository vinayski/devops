# DevOps

### Part 1: Provision Docker Image with Ansible

### Pre-reqs:
- [Ansible](https://docs.ansible.com/ansible/intro_installation.html)

### What it does:
- Sets up vpn inside a docker image using Ansible

### How to run:

```
docker pull megamanics/docker:vpn
docker run -p 8080:8080 --name vpn megamanics/docker:vpn
```

