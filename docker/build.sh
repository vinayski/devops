docker build --no-cache=true --label vpn-debian --rm  -t megamanics:vpn .
docker image prune
docker image ls
docker image inspect megamanics:vpn
docker image history megamanics:vpn
