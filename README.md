# DevOps

### Part 1: Provision Vagrant with Ansible

### Pre-reqs:
- [Vagrant](https://www.vagrantup.com/)
- [Ansible](https://docs.ansible.com/ansible/intro_installation.html)
- [Virtualbox](https://www.virtualbox.org/)

### What it does:
- Sets up nginx to work with an application

### How to run:

```
./provision.sh
```

one update was made to the provison.sh 
```
# Before
status_code=$(vagrant ssh -c "curl -k -s -o /dev/null -w \"%{http_code}\" https://127.0.0.1/" 2> /dev/null)
```
the http code quotes do not need to be escaped
```
# Check that status is 200 OK
status_code=$(vagrant ssh -c "curl -k -s -o /dev/null -w "%{http_code}" https://127.0.0.1/" 2> /dev/null)
```

