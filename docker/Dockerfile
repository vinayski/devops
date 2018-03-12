FROM debian:stretch-slim
MAINTAINER megamanics
LABEL version="0.0.1" \
      com.megamanics.isbeta= 
WORKDIR /tmp
RUN apt-get update && apt-get -qq install -y --no-install-recommends \
    ansible=2.* \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean \
 && echo "[local]" > /etc/ansible/hosts \ 
 && echo "localhost" >> /etc/ansible/hosts 
COPY ./* /tmp/
RUN ansible-playbook /tmp/playbook.yml -c local
#EXPOSE 22, 8080, 1666, 80, 443, 8881, 8882
#EXPOSE 8080, 80, 443, 8881, 8882
