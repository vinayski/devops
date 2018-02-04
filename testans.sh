#create host for centos
echo '[group1]
host01 ansible_ssh_user=cent'>myhosts
ansible group1 -i myhosts -m command -a date
#create playbook to check if latest version of sysstat is installed
#if older version or not present ansible should install the latest
echo '---
- hosts: host01

  become: true

  tasks:
    - name: ensure latest sysstat is installed
      apt:
        name: sysstat
        state: latest'>site.yml
ansible-playbook -i myhosts site.yml
#list docs
ansible-doc apt
# remove sysstat pkg
sed -i -e 's/state: latest/state: absent/' -e 's/ensure.*/ensure sysstat is removed/' site.yml
ansible-playbook -i myhosts site.yml
#install httpd
echo '
    - name: ensure httpd
      apt:
        name: nginx
        state: latest

    - name: start httpd
      service: name=nginx state=running

  handlers:
    -name: restart apache
    service: name=nginx state=restarted'>>site.yml
ansible-playbook -i myhosts site.yml

