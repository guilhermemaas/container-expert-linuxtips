#Machine Drivers:
#https://docs.docker.com/machine/drivers/

#Instalação do docker machine no Linuxs:
base=https://github.com/docker/machine/releases/download/v0.16.0 &&
  curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
  sudo mv /tmp/docker-machine /usr/local/bin/docker-machine &&
  chmod +x /usr/local/bin/docker-machine

  #Versão:
  docker-machine --version
  docker-machine version 0.16.0, build 702c267f

Latest version:
https://github.com/docker/machine/releases


#Criando uma nova docker Machine com VirtualBox:
docker-machine create --driver virtualbox giropops

#Verificar as máquinas:
docker-machine ls 
#NAME       ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER      ERRORS
#giropops   -        virtualbox   Running   tcp://192.168.99.100:2376           v19.03.12 

#Verificar o IP da máquina, nó:
docker-machine ip giropops

#Conectar ssh na máquina:
docker-machine ssh giropops

#Verificar váriáveis do node:
docker-machine env giropops

export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.99.100:2376"
export DOCKER_CERT_PATH="/home/ilhanublar/.docker/machine/machines/giropops"
export DOCKER_MACHINE_NAME="giropops"
# Run this command to configure your shell: 
# eval $(docker-machine env giropops)

#Para se conectar o CLI a machine, node:
eval $(docker-machine env NOME_DO_NODE)
#Basicamente vai dar um export conforme saída do comando docker-machine env giropops

#Estando conectado pode ser criado um container normalmente:
docker container run -d -p 8080:80 nginx
#-d = Rodar como daemon, em foregrounbd(Entrypoint)
#-p 8080 = Porta externa na máquina, node
#-p 80 = Porta do container #BIND DE PORTA

docker-machine ls
docker-machine ip giropops
curl IP:8080

#Parar a instância, node:
docker-machine stop giropops

#Inicia a instância, node:
docker-machine start giropops


docker-machine env -u
 $ docker-machine env -u
unset DOCKER_TLS_VERIFY
unset DOCKER_HOST
unset DOCKER_CERT_PATH
unset DOCKER_MACHINE_NAME
# Run this command to configure your shell: 
# eval $(docker-machine env -u)

#Para remover uma máquina, node:
docker-machine rm giropops