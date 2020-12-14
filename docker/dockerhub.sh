docker image prune
#Limpa as imagens full none.

docker image tag d6ccb7f102be gmaas2/ubuntu_vim_curl:6.0.0

docker image ls | grep gmaas2

#Logar no DockerHub:
docker login

#Push de uma imagem
docker push gmaas2/ubuntu_vim_curl

#Fazer pull/bixar/rodar container com essa imagem:
docker container run -d gmaas2/ubuntu_vim_curl:6.0.0

