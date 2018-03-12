#!/bin/sh
docker rm vpn
docker rmi megamanics/docker:vpn
docker build --no-cache=true --label vpn-debian --rm  -t megamanics/docker:vpn .
docker image     prune
docker container prune
#docker image ls
#docker image inspect megamanics/docker:vpn
docker image history megamanics/docker:vpn
#docker push megamanics/docker:vpn
docker run -d -l vpnc -P -it --name vpn megamanics/docker:vpn
docker attach vpn
